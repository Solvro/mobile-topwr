
import "dart:async";
import "dart:convert";
import "dart:io";

import "package:audio_service/audio_service.dart";
import "package:dio/dio.dart";
import "package:flutter/services.dart";
import "package:just_audio/just_audio.dart";
import "package:path/path.dart" as p;
import "package:path_provider/path_provider.dart";

import "../../../config/env.dart";

//Here the audio player is defined. Its created at app startup and is used for playing live stream.
//This whole class describes the audio player behavior, media items and metadata.
//This class acts as a bridge between the audio player (just_audio) and the audio service (audio_service).
//Thanks to that the audio player can talk to native APIs of audio services specific to the platform.
//Specifically, it allows the app to be recognized as a media player, which allows integration with Android Auto, CarPlay, etc.

const RADIO_LUZ_ARTWORK = "https://api.topwr.solvro.pl/uploads/28ef1261-47d5-4324-9f1f-9ae594af1327.png";
const REFRESH_INTERVAL = Duration(seconds: 15);

//used for AA and CP to display folders and media items
class _MediaIds {
  static const liveRadioFolder = "radio_luz_folder";
  static const liveRadioPlayable = "radio_luz_station";
  static const recentlyPlayed = "recently_played_folder";
  static const schedule = "schedule_folder";
}

class RadioAudioHandler extends BaseAudioHandler with SeekHandler {
  final _player = AudioPlayer();

  //used for fetching recently played and schedule
  final _dio = Dio(BaseOptions(
    baseUrl: Env.radioLuzApiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      "User-Agent": "RadioLuzApp/1.0 (Dart Dio)",
      "Accept": "*/*",
      "Content-Type": "application/x-www-form-urlencoded",
    },
  ));
  
  late MediaItem _radioLuzMediaItem;

  List<MediaItem>? _recentlyPlayedCache;
  DateTime? _recentlyPlayedLastFetch;
  static const _recentlyPlayedTtl = Duration(minutes: 1);

  List<MediaItem>? _scheduleCache;
  DateTime? _scheduleLastFetch;
  static const _scheduleTtl = Duration(minutes: 5);

  bool _isDisposed = false;

  Timer? _refreshTimer;

  RadioAudioHandler() {
    //main media item - live radio (information source)
    _radioLuzMediaItem = MediaItem(
      id: _MediaIds.liveRadioPlayable,
      title: "Radio LUZ",
      album: "Studenckie Radio",
      playable: true,
      artUri: Uri.parse(RADIO_LUZ_ARTWORK) //artwork cannot be local asset
    );
    
    _player.playbackEventStream.map(_transformEvent).listen(playbackState.add); //connecting 'just_audio' (flutter) to 'audio_service' (native)
    
    _player.sequenceStateStream.listen((state) {
        mediaItem.add(_radioLuzMediaItem);
    });
    
    _startPeriodicRefresh();
  }
  
  //refreshes now playing metadata
  void _startPeriodicRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(REFRESH_INTERVAL, (_) async {
      await _fetchNowPlaying();
    });
  }

  // Track when the stream was paused to detect stale buffers
  DateTime? _lastPauseTime;
  static const _staleStreamThreshold = Duration(seconds: 30);

  Future<void> _fetchNowPlaying() async {
    try {
      if (_isDisposed) return;
      final formData = FormData.fromMap({"action": "nowPlaying"});
      final response = await _dio.post<String>("admin-ajax.php", data: formData);
      
      if (response.data == null) return;
      
      final dynamic decoded = jsonDecode(response.data!);
      if (decoded is! Map<String, dynamic>) return;
      
      final nowPlaying = decoded["now"]?.toString();
      if (nowPlaying == null || nowPlaying.isEmpty) return;
      
      _radioLuzMediaItem = _radioLuzMediaItem.copyWith(album: nowPlaying);
      
      mediaItem.add(_radioLuzMediaItem);
    } catch (_) {
      //keep the old metadata
    }
  }

  @override
  Future<void> play() async {
    final now = DateTime.now();
    final isStale = _lastPauseTime != null && 
        now.difference(_lastPauseTime!) > _staleStreamThreshold;
    
    // If stream is stale or player is idle, reload the audio source
    if (isStale || _player.processingState == ProcessingState.idle) {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(Env.radioLuzStreamUrl),
          tag: _radioLuzMediaItem,
        ),
      );
      mediaItem.add(_radioLuzMediaItem);
    }
    
    _lastPauseTime = null;
    await _player.play();
  }

  @override
  Future<void> pause() async {
    _lastPauseTime = DateTime.now();
    await _player.pause();
  }

  @override
  Future<void> stop() async {
    _isDisposed = true;
    _refreshTimer?.cancel();
    await _player.stop();
    return super.stop();
  }

  //most crucial - defines the structure of the media library that is visible in AA and CP
  @override
  Future<List<MediaItem>> getChildren(String parentMediaId, [Map<String, dynamic>? options]) async {
    switch (parentMediaId) {
      case AudioService.browsableRootId:
        return [
          const MediaItem(
            id: _MediaIds.liveRadioFolder,
            title: "Radio LUZ",
            album: "Studenckie Radio",
            playable: false,
          ),  
          MediaItem(
            id: _MediaIds.recentlyPlayed,
            title: "Teraz gramy",
            playable: false,
          ),
          const MediaItem(
            id: _MediaIds.schedule,
            title: "Audycje",
            playable: false,
          ),
        ];
      
      case _MediaIds.liveRadioFolder:
        return [_radioLuzMediaItem];
      
      case _MediaIds.recentlyPlayed:
        return _fetchRecentlyPlayed();
      
      case _MediaIds.schedule:
        return _fetchSchedule();
      
      default:
        return [];
    }
  }
  
  Future<List<MediaItem>> _fetchRecentlyPlayed() async {
    final now = DateTime.now();
    if (_recentlyPlayedCache != null && 
        _recentlyPlayedLastFetch != null &&
        now.difference(_recentlyPlayedLastFetch!) < _recentlyPlayedTtl) {
      return _recentlyPlayedCache!;
    }
    
    try {
      final formData = FormData.fromMap({"action": "histoprylog"});
      final response = await _dio.post<String>("admin-ajax.php", data: formData);
      
      if (_isDisposed) return [];

      if (response.data == null) return _recentlyPlayedCache ?? [];
      
      final dynamic decoded = jsonDecode(response.data!);
      if (decoded is! List) return _recentlyPlayedCache ?? [];
      
      final items = decoded.map((e) {
        if (e is! List) return null;
        
        final timeRaw = e[1]?.toString() ?? "";
        final artist = e[2]?.toString() ?? "";
        final title = e[3]?.toString() ?? "";
        final album = e[4]?.toString() ?? "";
        
        final time = timeRaw.length >= 5 ? timeRaw.substring(0, 5) : "";
        
        return MediaItem(
          id: "history_${timeRaw}_$title",
          title: "$time - $title",
          artist: artist,
          album: album,
          playable: true,
        );
      }).whereType<MediaItem>().toList();
      
      //because title is in format "HH:MM - Title", it is sorted by time from latest to oldest
      items.sort((a, b) => b.title.compareTo(a.title));
      
      _recentlyPlayedCache = items;
      _recentlyPlayedLastFetch = now;
      
      return items;
    } catch (_) {
      return _recentlyPlayedCache ?? [];
    }
  }
  
  Future<List<MediaItem>> _fetchSchedule() async {
    final now = DateTime.now();
    if (_scheduleCache != null && 
        _scheduleLastFetch != null &&
        now.difference(_scheduleLastFetch!) < _scheduleTtl) {
      return _scheduleCache!;
    }
    
    try {
      final formData = FormData.fromMap({"action": "schedule"});
      final response = await _dio.post<String>("admin-ajax.php", data: formData);
      
      if (response.data == null) return _scheduleCache ?? [];
      
      final dynamic jsonMap = jsonDecode(response.data!);
      if (jsonMap is! Map<String, dynamic>) return _scheduleCache ?? [];

      final broadcasts = jsonMap["broadcasts"];
      if (broadcasts is! List) return _scheduleCache ?? [];
      
      final items = <MediaItem>[];
      
      for (final block in broadcasts) {
        if (block is! Map<String, dynamic>) continue;

        final isNow = block["isNow"] as bool? ?? false;
        final broadcastList = block["broadcasts"];

        if (broadcastList is! List) continue;
        
        for (final broadcast in broadcastList) {
          if (broadcast is! Map<String, dynamic>) continue;

          final b = broadcast;
          final time = b["time"]?.toString() ?? "";
          final title = b["title"]?.toString() ?? "";
          final thumbnail = b["thumbnail"];
          
          Uri? artUri;
          if (thumbnail is String && thumbnail.isNotEmpty) {
            artUri = Uri.tryParse(thumbnail);
          }
          
          items.add(MediaItem(
            id: "schedule_${b["id"]}",
            title: isNow ? "▶ $title" : title,
            album: time,
            playable: true,
            artUri: artUri,
          ));
        }
      }
      
      _scheduleCache = items;
      _scheduleLastFetch = now;
      
      return items;
    } catch (_) {
      return _scheduleCache ?? [];
    }
  }

  //mainly for getting info about recently played media item
  @override
  Future<MediaItem?> getItem(String mediaId) async {
    if (mediaId == _radioLuzMediaItem.id) {
      return _radioLuzMediaItem;
    }
    return mediaItem.value;
  }

  //start playing media item
  @override
  Future<void> playFromMediaId(String mediaId, [Map<String, dynamic>? extras]) async {
    //...because anything you click on should play the radio
    if (mediaId == _radioLuzMediaItem.id ||
        mediaId.startsWith("history_") ||
        mediaId.startsWith("schedule_")) {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(Env.radioLuzStreamUrl),
          tag: _radioLuzMediaItem,
        ),
      );
      mediaItem.add(_radioLuzMediaItem);
      await _player.play();
    }
    //this if might be useless but you never know...
  }

  Future<void> setVolume(double volume) => _player.setVolume(volume);

  Future<void> setAudioSource(AudioSource source) async {
    await _player.setAudioSource(source);
    if (source is UriAudioSource && source.tag is MediaItem) {
       mediaItem.add((source.tag as MediaItem).copyWith(playable: true));
    }
  }

  //this is where the audio player (just_audio) and audio service (audio_service) connect
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        if (_player.playing) MediaControl.pause else MediaControl.play,
      ],
      systemActions: const {
        MediaAction.seek,
      },
      androidCompactActionIndices: const [0],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }

  Stream<double> get volume => _player.volumeStream;
  Stream<PlayerState> get playerState => _player.playerStateStream;
  Duration get bufferedPosition => _player.bufferedPosition;
}

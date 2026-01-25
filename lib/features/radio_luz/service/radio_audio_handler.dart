import "dart:async";
import "dart:convert";

import "package:audio_service/audio_service.dart";
import "package:audio_session/audio_session.dart";
import "package:dio/dio.dart";
import "package:flutter/widgets.dart";
import "package:just_audio/just_audio.dart";

import "../../../config/env.dart";
import "../data/models/history_entry.dart";
import "../data/models/now_playing.dart";
import "../data/models/schedule.dart";

//Here the audio player is defined. Its created at app startup and is used for playing live stream.
//This whole class describes the audio player behavior, media items and metadata.
//This class acts as a bridge between the audio player (just_audio) and the audio service (audio_service).
//Thanks to that the audio player can talk to native APIs of audio services specific to the platform.
//Specifically, it allows the app to be recognized as a media player, which allows integration with Android Auto, CarPlay, etc.

const radioLuzArtwork = "https://api.topwr.solvro.pl/uploads/28ef1261-47d5-4324-9f1f-9ae594af1327.png";
const refreshInterval = Duration(seconds: 15);
const staleStreamThreshold = Duration(seconds: 30);

//used for AA and CP to display folders and media items
class _MediaIds {
  static const liveRadioFolder = "radio_luz_folder";
  static const liveRadioPlayable = "radio_luz_station";
  static const recentlyPlayed = "recently_played_folder";
  static const schedule = "schedule_folder";
}

class RadioAudioHandlerBridge extends BaseAudioHandler with SeekHandler, WidgetsBindingObserver {
  final _player = AudioPlayer();

  //used for fetching recently played and schedule
  final _dio = Dio(
    BaseOptions(
      baseUrl: Env.radioLuzApiUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "User-Agent": "RadioLuzApp/1.0 (Dart Dio)",
        "Accept": "*/*",
        "Content-Type": "application/x-www-form-urlencoded",
      },
    ),
  );

  //main media item - live radio (information source)
  var _radioLuzMediaItem = MediaItem(
    id: _MediaIds.liveRadioPlayable,
    title: "Radio LUZ",
    album: "Studenckie Radio",
    artUri: Uri.parse(radioLuzArtwork), //artwork cannot be local asset
  );

  List<MediaItem>? _recentlyPlayedCache;
  DateTime? _recentlyPlayedLastFetch;
  static const _recentlyPlayedTtl = Duration(minutes: 1);

  List<MediaItem>? _scheduleCache;
  DateTime? _scheduleLastFetch;
  static const _scheduleTtl = Duration(minutes: 5);

  var _isDisposed = false;

  Timer? _refreshTimer;
  StreamSubscription<PlaybackState>? _playbackEventSubscription;
  StreamSubscription<SequenceState?>? _sequenceStateSubscription;

  RadioAudioHandlerBridge() {
    _initializeListeners();
  }

  void _initializeListeners() {
    //connect 'just_audio' (Flutter) to 'audio_service' (native)
    _playbackEventSubscription = _player.playbackEventStream.map(_transformEvent).listen(playbackState.add);

    _sequenceStateSubscription = _player.sequenceStateStream.listen((state) {
      mediaItem.add(_radioLuzMediaItem);
    });

    //periodically refresh now playing metadata
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(refreshInterval, (_) async {
      await _fetchNowPlaying();
    });

    //pre-configure audio session for iOS to reduce playback startup latency
    unawaited(_initAudioSession());

    //register lifecycle observer to stop playback when app is killed
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Stop playback when app is detached (killed)
    if (state == AppLifecycleState.detached) {
      unawaited(stop());
    }
  }

  /// iOS audio session
  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(
      const AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playback,
        avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.allowBluetooth,
        avAudioSessionMode: AVAudioSessionMode.defaultMode,
        avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: AndroidAudioAttributes(
          contentType: AndroidAudioContentType.music,
          usage: AndroidAudioUsage.media,
        ),
        androidWillPauseWhenDucked: false,
      ),
    );
  }

  //track when the stream was paused to detect stale buffers
  DateTime? _lastPauseTime;

  Future<void> _fetchNowPlaying() async {
    try {
      if (_isDisposed) return;
      final formData = FormData.fromMap({"action": "nowPlaying"});
      final response = await _dio.post<String>("admin-ajax.php", data: formData);

      if (response.data == null) return;

      final dynamic decoded = jsonDecode(response.data!);
      if (decoded is! Map<String, dynamic>) return;

      final nowPlaying = NowPlaying.fromJson(decoded);
      if (nowPlaying.now == null || nowPlaying.now!.isEmpty) return;

      _radioLuzMediaItem = _radioLuzMediaItem.copyWith(album: nowPlaying.now, artist: nowPlaying.now);

      mediaItem.add(_radioLuzMediaItem);
    } on Exception catch (_) {
      //keep the old metadata
    }
  }

  ///pre-loads the audio stream
  Future<void> preload() async {
    if (_player.processingState == ProcessingState.idle) {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(Env.radioLuzStreamUrl), tag: _radioLuzMediaItem));
      mediaItem.add(_radioLuzMediaItem);
    }
  }

  @override
  Future<void> play() async {
    final now = DateTime.now();
    final isStale = _lastPauseTime != null && now.difference(_lastPauseTime!) > staleStreamThreshold;

    _lastPauseTime = null;

    //if stream is stale or player is idle, reload the audio source
    if (isStale || _player.processingState == ProcessingState.idle) {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(Env.radioLuzStreamUrl), tag: _radioLuzMediaItem));
      mediaItem.add(_radioLuzMediaItem);
    }

    unawaited(_player.play());
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
    await _playbackEventSubscription?.cancel();
    await _sequenceStateSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
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
          const MediaItem(id: _MediaIds.recentlyPlayed, title: "Teraz gramy", playable: false),
          const MediaItem(id: _MediaIds.schedule, title: "Audycje", playable: false),
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

      final items = decoded.whereType<List<dynamic>>().map((e) {
        final entry = HistoryEntry.fromList(e);
        final timeStr = "${entry.time.hour.toString().padLeft(2, '0')}:${entry.time.minute.toString().padLeft(2, '0')}";
        return MediaItem(
          id: "history_${entry.date}_${entry.title}",
          title: "$timeStr - ${entry.title}",
          artist: entry.artist,
          album: entry.album,
        );
      }).toList();

      //because title is in format "HH:MM - Title", it is sorted by time from latest to oldest
      items.sort((a, b) => b.title.compareTo(a.title));

      _recentlyPlayedCache = items;
      _recentlyPlayedLastFetch = now;

      return items;
    } on Exception catch (_) {
      return _recentlyPlayedCache ?? [];
    }
  }

  Future<List<MediaItem>> _fetchSchedule() async {
    final now = DateTime.now();
    if (_scheduleCache != null && _scheduleLastFetch != null && now.difference(_scheduleLastFetch!) < _scheduleTtl) {
      return _scheduleCache!;
    }

    try {
      final formData = FormData.fromMap({"action": "schedule"});
      final response = await _dio.post<String>("admin-ajax.php", data: formData);

      if (response.data == null) return _scheduleCache ?? [];

      final dynamic jsonMap = jsonDecode(response.data!);
      if (jsonMap is! Map<String, dynamic>) return _scheduleCache ?? [];

      final schedule = Schedule.fromJson(jsonMap);

      final items = <MediaItem>[];

      for (final block in schedule.broadcasts) {
        final isNow = block.isNow ?? false;

        for (final broadcast in block.broadcasts) {
          Uri? artUri;
          if (broadcast.thumbnail != null && broadcast.thumbnail!.isNotEmpty) {
            artUri = Uri.tryParse(broadcast.thumbnail!);
          }

          items.add(
            MediaItem(
              id: "schedule_${broadcast.id}",
              title: isNow ? "▶ ${broadcast.title}" : broadcast.title,
              album: broadcast.time,
              artUri: artUri,
            ),
          );
        }
      }

      _scheduleCache = items;
      _scheduleLastFetch = now;

      return items;
    } on Exception catch (_) {
      return _scheduleCache ?? [];
    }
  }

  //start playing media item
  @override
  Future<void> playFromMediaId(String mediaId, [Map<String, dynamic>? extras]) async {
    //...because anything you click on should play the radio
    if (mediaId == _radioLuzMediaItem.id || mediaId.startsWith("history_") || mediaId.startsWith("schedule_")) {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(Env.radioLuzStreamUrl), tag: _radioLuzMediaItem));
      mediaItem.add(_radioLuzMediaItem);
      unawaited(_player.play());
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
      controls: [if (_player.playing) MediaControl.pause else MediaControl.play],
      systemActions: const {MediaAction.seek},
      androidCompactActionIndices: const [0],
      processingState: switch (_player.processingState) {
        ProcessingState.idle => AudioProcessingState.idle,
        ProcessingState.loading => AudioProcessingState.loading,
        ProcessingState.buffering => AudioProcessingState.buffering,
        ProcessingState.ready => AudioProcessingState.ready,
        ProcessingState.completed => AudioProcessingState.completed,
      },
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

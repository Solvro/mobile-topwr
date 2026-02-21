import "dart:async";

import "package:audio_service/audio_service.dart";
import "package:audio_session/audio_session.dart";
import "package:flutter/widgets.dart";
import "package:just_audio/just_audio.dart";

import "../../../config/env.dart";
import "../data/client/radio_luz_client.dart";
import "../data/repository/radio_luz_repository.dart";

//Here the audio player is defined. Its created at app startup and is used for playing live stream.
//This whole class describes the audio player behavior, media items and metadata.
//This class acts as a bridge between the audio player (just_audio) and the audio service (audio_service).
//Thanks to that the audio player can talk to native APIs of audio services specific to the platform.
//Specifically, it allows the app to be recognized as a media player, which allows integration with Android Auto, CarPlay, etc.

const radioLuzArtwork = "https://api.topwr.solvro.pl/uploads/28ef1261-47d5-4324-9f1f-9ae594af1327.png";
const refreshInterval = Duration(seconds: 15);
const staleStreamThreshold = Duration(seconds: 30);

class RadioAudioHandlerBridge extends BaseAudioHandler with SeekHandler, WidgetsBindingObserver {
  final _player = AudioPlayer();

  //used for fetching now playing metadata
  final RadioLuzRepository _repository;

  //main media item - live radio (information source)
  var _radioLuzMediaItem = MediaItem(
    id: "radio_luz_station",
    title: "Radio LUZ",
    album: "Studenckie Radio",
    artUri: Uri.parse(radioLuzArtwork), //artwork cannot be local asset
  );

  var _isDisposed = false;

  Timer? _refreshTimer;
  StreamSubscription<PlaybackState>? _playbackEventSubscription;
  StreamSubscription<SequenceState?>? _sequenceStateSubscription;

  RadioAudioHandlerBridge() : _repository = RadioLuzRepository(createRadioLuzDio()) {
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
      final nowPlaying = await _repository.getNowPlaying();

      if (nowPlaying == null || nowPlaying.now == null || nowPlaying.now!.isEmpty) {
        return;
      }

      _radioLuzMediaItem = _radioLuzMediaItem.copyWith(album: nowPlaying.now, artist: nowPlaying.now);

      mediaItem.add(_radioLuzMediaItem);
    } on Exception catch (_) {
      //keep the old metadata
    }
  }

  ///pre-loads the audio stream
  Future<void> _loadStream() async {
    await _player.setAudioSource(AudioSource.uri(Uri.parse(Env.radioLuzStreamUrl), tag: _radioLuzMediaItem));
    mediaItem.add(_radioLuzMediaItem);
  }

  Future<void> preload() async {
    if (_player.processingState == ProcessingState.idle) {
      await _loadStream();
    }
  }

  @override
  Future<void> play() async {
    final now = DateTime.now();
    final isStale = _lastPauseTime != null && now.difference(_lastPauseTime!) > staleStreamThreshold;

    _lastPauseTime = null;

    //if stream is stale or player is idle, reload the audio source
    if (isStale || _player.processingState == ProcessingState.idle) {
      await _loadStream();
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

  //defines the media library visible in Android Auto and CarPlay
  @override
  Future<List<MediaItem>> getChildren(String parentMediaId, [Map<String, dynamic>? options]) async {
    if (parentMediaId == AudioService.browsableRootId) {
      return [_radioLuzMediaItem];
    }
    return [];
  }

  @override
  Future<void> playFromMediaId(String mediaId, [Map<String, dynamic>? extras]) async {
    if (mediaId == _radioLuzMediaItem.id) {
      await _loadStream();
      unawaited(_player.play());
    }
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

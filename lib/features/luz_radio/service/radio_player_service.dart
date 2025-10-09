import "dart:async";

import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";

class RadioPlayerService {
  static final _instance = RadioPlayerService._internal();
  factory RadioPlayerService() => _instance;

  RadioPlayerService._internal();

  final _player = AudioPlayer();
  double _volume = 1;
  final _volumeController = StreamController<double>.broadcast();

  AudioPlayer get player => _player;
  double get volume => _volume;
  Stream<double> get volumeStream => _volumeController.stream;
  bool get isPlaying => _player.playing;
  Stream<bool> get isPlayingStream => _player.playingStream;

  Future<void> init() async {
    final audioSource = AudioSource.uri(
      Uri.parse("https://stream.radioluz.pl:8443/luz_hifi.mp3"),
      tag: const MediaItem(id: "1", title: "Radio LUZ"),
    );

    await _player.setAudioSource(audioSource);
    await _player.setVolume(_volume);
  }

  Future<void> play() async {
    if (!_player.playing) {
      await init();
    }
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> setVolume(double newVolume) async {
    _volume = newVolume;
    await _player.setVolume(_volume);
    _volumeController.add(_volume);
  }
}

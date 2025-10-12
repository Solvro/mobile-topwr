import "dart:async";

import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";

import "../../../config/url_config.dart";
import "../../../utils/context_extensions.dart";

class RadioPlayerService {
  static final _instance = RadioPlayerService._internal();
  factory RadioPlayerService() => _instance;

  RadioPlayerService._internal();

  final _player = AudioPlayer();
  double _volume = 1;
  final _volumeController = StreamController<double>.broadcast();

  AudioPlayer get player => _player;
  bool get isPlaying => _player.playing;
  double get volume => _volume;
  Stream<double> get volumeStream => _volumeController.stream;

  Future<void> init(BuildContext context) async {
    final audioSource = AudioSource.uri(
      Uri.parse(UrlConfig.luzRadioStreamUrl),
      tag: MediaItem(id: "1", title: context.localize.radio_luz),
    );

    await _player.setAudioSource(audioSource);
    await _player.setVolume(_volume);
  }

  Future<void> play(BuildContext context) async {
    if (!_player.playing) {
      await init(context);
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

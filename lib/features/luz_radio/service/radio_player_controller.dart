import "dart:async";

import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/url_config.dart";
import "../../../utils/context_extensions.dart";
import "radio_player_provider.dart";
import "radio_state.dart";

part "radio_player_controller.g.dart";

@riverpod
class RadioController extends _$RadioController {
  late final AudioPlayer _player = ref.watch(radioPlayerProvider);

  StreamSubscription<bool>? _playingStream;
  StreamSubscription<double>? _volumeStream;
  StreamSubscription<ProcessingState>? _loadingStream;

  _AppLifecycleStopper? _stopper;

  @override
  RadioState build() {
    state = const RadioState();

    _stopper = _AppLifecycleStopper(_player);

    _playingStream = _player.playingStream.listen((playing) {
      state = state.copyWith(isPlaying: playing);
    });

    _volumeStream = _player.volumeStream.listen((v) {
      state = state.copyWith(volume: v);
    });

    _loadingStream = _player.processingStateStream.listen((processingState) {
      final loading = processingState == ProcessingState.loading || processingState == ProcessingState.buffering;
      state = state.copyWith(isLoading: loading);

      if (processingState == ProcessingState.completed) {
        state = state.copyWith(isPlaying: false);
      }
    });

    ref.onDispose(() async {
      _stopper?.dispose();

      await _playingStream?.cancel();
      await _volumeStream?.cancel();
      await _loadingStream?.cancel();
    });

    return state;
  }

  Future<void> _ensureInitialized(BuildContext context) async {
    if (state.isInitialized) return;

    final audioSource = AudioSource.uri(
      Uri.parse(UrlConfig.luzRadioStreamUrl),
      tag: MediaItem(id: "1", title: context.localize.radio_luz),
    );

    await _player.setAudioSource(audioSource);
    await _player.setVolume(state.volume);

    state = state.copyWith(isInitialized: true);
  }

  Future<void> play(BuildContext context) async {
    await _ensureInitialized(context);
    await _player.play();
  }

  Future<void> pause(BuildContext context) async {
    await _ensureInitialized(context);
    await _player.pause();
  }

  Future<void> stop(BuildContext context) async {
    await _ensureInitialized(context);
    await _player.stop();
  }

  Future<void> setVolume(double newVolume) async {
    await _player.setVolume(newVolume);
  }
}

class _AppLifecycleStopper with WidgetsBindingObserver {
  final AudioPlayer player;

  _AppLifecycleStopper(this.player) {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached) {
      if (player.playing) {
        await player.stop();
      }
    }
  }
}

import "dart:async";
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:path/path.dart" as p;
import "package:path_provider/path_provider.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/url_config.dart";
import "../../../gen/assets.gen.dart";
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

    final title = context.localize.radio_luz;
    final album = context.localize.pwr;

    final assetPath = Assets.png.radioLuz.radioLuzLogo.path;
    final artUri = await assetToFileUri(assetPath);

    final audioSource = AudioSource.uri(
      Uri.parse(UrlConfig.luzRadioStreamUrl),
      tag: MediaItem(id: "1", title: title, album: album, artUri: artUri),
    );

    await _player.setAudioSource(audioSource);
    await _player.setVolume(state.volume);

    state = state.copyWith(isInitialized: true);
  }

  Future<Uri> assetToFileUri(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final fileName = p.basename(assetPath);
    final file = File(p.join(tempDir.path, fileName));

    await file.writeAsBytes(bytes, flush: true);
    return file.uri;
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

// responsible for stoping the player when the user swipes away the app (force kill) on Android
// however, the app is still running altough its not visible to the user
// when the user opens the app again it will have the same state as when it was closed
// if the user does not use the app for some time, the android will kill the process
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

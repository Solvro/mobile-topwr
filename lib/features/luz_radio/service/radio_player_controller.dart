import "dart:async";
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:path/path.dart" as p;
import "package:path_provider/path_provider.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/env.dart";
import "../../../gen/assets.gen.dart";
import "../../../l10n/app_localizations.dart";
import "audio_player_streams.dart";
import "radio_player_provider.dart";
import "radio_state.dart";

part "radio_player_controller.g.dart";

@Riverpod(keepAlive: true)
class RadioController extends _$RadioController {
  late final AudioPlayer _player = ref.watch(radioPlayerProvider);

  _AppLifecycleStopper? _stopper;
  var _isInitialized = false;

  @override
  RadioState build() {
    _stopper ??= _AppLifecycleStopper(_player);
    ref.onDispose(() => _stopper?.dispose());

    final isPlayingProvider = ref.watch(audioPlayerIsPlayingProvider);
    final volumeProvider = ref.watch(audioPlayerVolumeProvider);
    final processingStateProvider = ref.watch(audioPlayerProcessingStateProvider);

    final isPlaying = isPlayingProvider.value ?? false;
    final volume = volumeProvider.value ?? 1.0;
    final processingState = processingStateProvider.valueOrNull;
    final isLoading = processingState == ProcessingState.loading || processingState == ProcessingState.buffering;

    return RadioState(isPlaying: isPlaying, volume: volume, isLoading: isLoading);
  }

  Future<void> _ensureInitialized(AppLocalizations l10n) async {
    if (_isInitialized) return;

    final title = l10n.radio_luz;
    final album = l10n.pwr;

    final assetPath = Assets.png.radioLuz.radioLuzLogo.path;
    final artUri = await assetToFileUri(assetPath);

    final audioSource = AudioSource.uri(
      Uri.parse(Env.radioLuzStreamUrl),
      tag: MediaItem(id: "1", title: title, album: album, artUri: artUri),
    );

    await _player.setAudioSource(audioSource);
    await _player.setVolume(state.volume);

    _isInitialized = true;
  }

  Future<void> init(AppLocalizations l10n) => _ensureInitialized(l10n);

  Future<Uri> assetToFileUri(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final fileName = p.basename(assetPath);
    final file = File(p.join(tempDir.path, fileName));

    await file.writeAsBytes(bytes, flush: true);
    return file.uri;
  }

  Future<void> play(AppLocalizations l10n) async {
    await _ensureInitialized(l10n);
    await _player.play();
  }

  Future<void> pause(AppLocalizations l10n) async {
    await _ensureInitialized(l10n);
    await _player.pause();
  }

  Future<void> stop(AppLocalizations l10n) async {
    await _ensureInitialized(l10n);
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

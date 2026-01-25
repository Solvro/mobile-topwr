import "dart:async";
import "dart:io";

import "package:flutter/services.dart";
import "package:just_audio/just_audio.dart";
import "package:path/path.dart" as p;
import "package:path_provider/path_provider.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/models/audio_player_strings.dart";
import "audio_player_streams.dart";
import "radio_audio_handler.dart";
import "radio_player_provider.dart";
import "radio_state.dart";

part "radio_player_controller.g.dart";

@Riverpod(keepAlive: true)
class RadioController extends _$RadioController {
  late final RadioAudioHandlerBridge _handler = ref.watch(radioPlayerProvider);

  var _initialized = false;

  @override
  RadioState build() {
    final volumeProvider = ref.watch(audioPlayerVolumeProvider);
    final volume = volumeProvider.value ?? 1.0;

    final playerStateProvider = ref.watch(audioPlayerStateProvider);

    final processingState = playerStateProvider.value?.processingState;

    final isPlaying = (playerStateProvider.value?.playing ?? false) && processingState == ProcessingState.ready;
    final isLoading = processingState == ProcessingState.loading || processingState == ProcessingState.buffering;

    return RadioState(isPlaying: isPlaying, isLoading: isLoading, volume: volume);
  }

  void init(AudioPlayerStrings audioPlayerStrings) {
    if (_initialized) return;
    _initialized = true;
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

  ///pre-loads the audio stream to reduce startup delay
  Future<void> preload() async {
    await _handler.preload();
  }

  Future<void> play() async {
    const durationGuard = Duration(milliseconds: 200);
    final duration = _handler.bufferedPosition;
    await _handler.seek(duration > durationGuard ? duration - durationGuard : Duration.zero);

    await _handler.play();
  }

  Future<void> pause() async {
    await _handler.pause();
  }
  
  Future<void> setVolume(double newVolume) async {
    await _handler.setVolume(newVolume);
  }
}

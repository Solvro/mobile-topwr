import "dart:async";
import "dart:io";

import "package:audio_service/audio_service.dart";
import "package:flutter/services.dart";
import "package:just_audio/just_audio.dart";
import "package:path/path.dart" as p;
import "package:path_provider/path_provider.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/env.dart";
import "../../../gen/assets.gen.dart";
import "../data/models/audio_player_strings.dart";
import "audio_player_streams.dart";
import "radio_audio_handler.dart";
import "radio_player_provider.dart";
import "radio_state.dart";

part "radio_player_controller.g.dart";

@Riverpod(keepAlive: true)
class RadioController extends _$RadioController {
  late final RadioAudioHandler _handler = ref.watch(radioPlayerProvider);
  late final AudioPlayerStrings _audioPlayerStrings;

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

  Future<void> _initPlayer() async {
    final assetPath = Assets.png.radioLuz.radioLuzLogo.path;
    final artUri = await assetToFileUri(assetPath);

    final audioSource = AudioSource.uri(
      Uri.parse(Env.radioLuzStreamUrl),
      tag: MediaItem(id: "1", title: _audioPlayerStrings.title, album: _audioPlayerStrings.album, artUri: artUri),
    );

    await _handler.setAudioSource(audioSource);

    final volume = ref.read(audioPlayerVolumeProvider).value ?? 1.0;
    await _handler.setVolume(volume);
  }

  void init(AudioPlayerStrings audioPlayerStrings) {
    if (_initialized) return;
    _audioPlayerStrings = audioPlayerStrings;
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

  Future<void> play() async {
    const durationGuard = Duration(milliseconds: 200);
    final duration = _handler.bufferedPosition;
    await _handler.seek(duration > durationGuard ? duration - durationGuard : Duration.zero);

    await _handler.play();
  }

  Future<void> pause() async {
    await _handler.pause();
  }

  Future<void> stop() async {
    await _handler.stop();
  } //i don't think we need this, but keeping just in case

  Future<void> setVolume(double newVolume) async {
    await _handler.setVolume(newVolume);
  }
}

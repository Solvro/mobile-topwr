import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:just_audio/just_audio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "radio_player_provider.dart";

part "audio_player_streams.g.dart";

@riverpod
Stream<bool> audioPlayerIsPlaying(Ref ref) {
  final player = ref.watch(radioPlayerProvider);
  return player.playingStream;
}

@riverpod
Stream<double> audioPlayerVolume(Ref ref) {
  final player = ref.watch(radioPlayerProvider);
  return player.volumeStream;
}

@riverpod
Stream<ProcessingState> audioPlayerProcessingState(Ref ref) {
  final player = ref.watch(radioPlayerProvider);
  return player.processingStateStream;
}

import "package:just_audio/just_audio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "radio_player_provider.dart";

part "audio_player_streams.g.dart";

@riverpod
Stream<PlayerState> audioPlayerState(Ref ref) {
  final handler = ref.watch(radioPlayerProvider);
  return handler.playerState;
}

@riverpod
Stream<double> audioPlayerVolume(Ref ref) {
  final handler = ref.watch(radioPlayerProvider);
  return handler.volume;
}

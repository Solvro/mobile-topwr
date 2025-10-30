import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:just_audio/just_audio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "radio_player_provider.dart";

part "audio_player_streams.g.dart";

@riverpod
Stream<PlayerState> audioPlayerState(Ref ref) {
  final player = ref.watch(radioPlayerProvider);
  return player.playerStateStream;
}

@riverpod
Stream<double> audioPlayerVolume(Ref ref) {
  final player = ref.watch(radioPlayerProvider);
  return player.volumeStream;
}

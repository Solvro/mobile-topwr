import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:just_audio/just_audio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "radio_player_provider.g.dart";

// @Riverpod(keepAlive: true)
// class RadioPlayer extends _$RadioPlayer {
//   @override
//   AudioPlayer build() {
//     final player = AudioPlayer();
//     ref.onDispose(player.dispose);
//     return player;
//   }
// }

@Riverpod(keepAlive: true)
AudioPlayer radioPlayer(Ref ref) {
  final player = AudioPlayer();
  ref.onDispose(player.dispose);
  return player;
}

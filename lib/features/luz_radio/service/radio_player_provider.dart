import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:just_audio/just_audio.dart";

final radioPlayerProvider = Provider<AudioPlayer>((ref) {
  final player = AudioPlayer();
  ref.onDispose(player.dispose);
  return player;
});

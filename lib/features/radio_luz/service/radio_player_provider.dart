
import "package:riverpod_annotation/riverpod_annotation.dart";

import "radio_audio_handler.dart";

part "radio_player_provider.g.dart";

//we only need to define the provider here
//the actual implementation is in radio_audio_handler.dart
//the player is assigned in main.dart so it starts even before app is fully loaded

@Riverpod(keepAlive: true)
RadioAudioHandler radioPlayer(Ref ref) {
  throw UnimplementedError("radioPlayer provider must be overridden in main.dart");
}

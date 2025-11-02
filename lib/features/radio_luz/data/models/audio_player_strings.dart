import "package:freezed_annotation/freezed_annotation.dart";

part "audio_player_strings.freezed.dart";

@freezed
abstract class AudioPlayerStrings with _$AudioPlayerStrings {
  const factory AudioPlayerStrings({required String title, required String album}) = _AudioPlayerStrings;
}

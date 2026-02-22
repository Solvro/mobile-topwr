import "package:freezed_annotation/freezed_annotation.dart";

part "radio_state.freezed.dart";

@freezed
abstract class RadioState with _$RadioState {
  const factory RadioState({
    @Default(false) bool isPlaying,
    @Default(false) bool isLoading,
    @Default(1.0) double volume,
    @Default(false) bool isMuted,
  }) = _RadioState;
}

import "package:freezed_annotation/freezed_annotation.dart";

part "ramp.freezed.dart";
part "ramp.g.dart";

@freezed
class Ramp with _$Ramp {
  const factory Ramp({
    required RampTranslations translations,
  }) = _Ramp;

  factory Ramp.fromJson(Map<String, dynamic> json) => _$RampFromJson(json);
}

@freezed
class RampTranslations with _$RampTranslations {
  const factory RampTranslations({
    @JsonKey(name: "pl") required RampTranslation plTranslation,
  }) = _RampTranslations;

  factory RampTranslations.fromJson(Map<String, dynamic> json) =>
      _$RampTranslationsFromJson(json);
}

@freezed
class RampTranslation with _$RampTranslation {
  const factory RampTranslation({
    required String location,
  }) = _RampTranslation;

  factory RampTranslation.fromJson(Map<String, dynamic> json) =>
      _$RampTranslationFromJson(json);
}

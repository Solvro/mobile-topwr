import "package:freezed_annotation/freezed_annotation.dart";

part "stairway.g.dart";
part "stairway.freezed.dart";

@freezed
class Stairway with _$Stairway {
  const factory Stairway({
    required StairwayTranslations translations,
  }) = _Stairway;

  factory Stairway.fromJson(Map<String, dynamic> json) =>
      _$StairwayFromJson(json);
}

@freezed
class StairwayTranslations with _$StairwayTranslations {
  const factory StairwayTranslations({
    @JsonKey(name: "pl") required StairwayTranslation plTranslation,
  }) = _StairwayTranslations;

  factory StairwayTranslations.fromJson(Map<String, dynamic> json) =>
      _$StairwayTranslationsFromJson(json);
}

@freezed
class StairwayTranslation with _$StairwayTranslation {
  const factory StairwayTranslation({
    required String name,
  }) = _StairwayTranslation;

  factory StairwayTranslation.fromJson(Map<String, dynamic> json) =>
      _$StairwayTranslationFromJson(json);
}

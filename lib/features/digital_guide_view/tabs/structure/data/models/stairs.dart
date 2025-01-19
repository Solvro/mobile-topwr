import "package:freezed_annotation/freezed_annotation.dart";

part "stairs.g.dart";
part "stairs.freezed.dart";

@freezed
class Stairs with _$Stairs {
  const factory Stairs({
    required StairsTranslations translations,
  }) = _Stairs;

  factory Stairs.fromJson(Map<String, dynamic> json) => _$StairsFromJson(json);
}

@freezed
class StairsTranslations with _$StairsTranslations {
  const factory StairsTranslations ({
    required StairsTranslation plTranslation,
  }) = _StairsTranslations;

  factory StairsTranslations.fromJson(Map<String, dynamic> json) => _$StairsTranslationsFromJson(json);
}

@freezed
class StairsTranslation with _$StairsTranslation {
  const factory StairsTranslation ({
    required String name,
  }) = _StairsTranslation;

  factory StairsTranslation.fromJson(Map<String, dynamic> json) => _$StairsTranslationFromJson(json);
}

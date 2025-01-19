import "package:freezed_annotation/freezed_annotation.dart";

part "corridor.freezed.dart";
part "corridor.g.dart";

@freezed
class Corridor with _$Corridor {
  const factory Corridor({
    required CorridorTranslations translations,
  }) = _Corridor;

  factory Corridor.fromJson(Map<String, dynamic> json) => _$CorridorFromJson(json);
}

@freezed
class CorridorTranslations with _$CorridorTranslations {
  const factory CorridorTranslations ({
    required CorridorTranslation plTranslation,
  }) = _CorridorTranslations;

  factory CorridorTranslations.fromJson(Map<String, dynamic> json) => _CorridorTranslationsFromJson(json);
}

@freezed
class CorridorTranslation with _$CorridorTranslation {
  const factory CorridorTranslation ({
    required String name,
  }) = _CorridorTranslation;

  factory CorridorTranslation.fromJson(Map<String,dynamic> json) => CorridorTranslationFromJson(json);
}

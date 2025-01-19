import "package:freezed_annotation/freezed_annotation.dart";

part "toilet.g.dart";
part "toilet.freezed.dart";

@freezed
class Toilet with _$Toilet {
  const factory Toilet({
    required ToiletTranslations translations,
    @JsonKey(name: "is_available_for", fromJson: decideMenToilet) required bool menToilet,
  }) = _Toilet;

  factory Toilet.fromJson(Map<String, dynamic> json) => _$ToiletFromJson(json);
}

@freezed
class  ToiletTranslations with _$ToiletTranslations {
  const factory ToiletTranslations ({
    @JsonKey(name: "pl") required ToiletTranslation plTranslation,
  }) = _ToiletTranslations;

  factory ToiletTranslations.fromJson(Map<String, dynamic> json) => _$ToiletTranslationsFromJson(json);
}

@freezed
class ToiletTranslation with _$ToiletTranslation {
  const factory ToiletTranslation ({
    required String location,
  }) = _ToiletTranslation;

  factory ToiletTranslation.fromJson(Map<String, dynamic> json) => _$ToiletTranslationFromJson(json);
}

bool decideMenToilet(String option) {
  return option == "1";
}

import "package:freezed_annotation/freezed_annotation.dart";

part "lodge.g.dart";
part "lodge.freezed.dart";

@freezed
class Lodge with _$Lodge {
  const factory Lodge({
    required LodgeTranslations translations,
  }) = _Lodge;

  factory Lodge.fromJson(Map<String, dynamic> json) => _$LodgeFromJson(json);
}

@freezed
class LodgeTranslations with _$LodgeTranslations {
  const factory LodgeTranslations({
    @JsonKey(name: "pl") required LodgeTranslation plTranslation,
  }) = _LodgeTranslations;

  factory LodgeTranslations.fromJson(Map<String, dynamic> json) =>
      _$LodgeTranslationsFromJson(json);
}

@freezed
class LodgeTranslation with _$LodgeTranslation {
  const factory LodgeTranslation({
    required String location,
  }) = _LodgeTranslation;

  factory LodgeTranslation.fromJson(Map<String, dynamic> json) =>
      _$LodgeTranslationFromJson(json);
}

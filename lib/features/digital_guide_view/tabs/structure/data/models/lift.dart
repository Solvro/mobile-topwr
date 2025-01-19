import "package:freezed_annotation/freezed_annotation.dart";

part "lift.freezed.dart";
part "lift.g.dart";

@freezed
class Lift with _$Lift {
  const factory Lift({
    required LiftTranslations translations,
  }) = _Lift;

  factory Lift.fromJson(Map<String, dynamic> json) => _$LiftFromJson(json);
}

@freezed
class LiftTranslations with _$LiftTranslations {
  const factory LiftTranslations({
    @JsonKey(name: "pl") required LiftTranslation plTranslation,
  }) = _LiftTranslations;

  factory LiftTranslations.fromJson(Map<String, dynamic> json) =>
      _$LiftTranslationsFromJson(json);
}

@freezed
class LiftTranslation with _$LiftTranslation {
  const factory LiftTranslation({
    required String location,
  }) = _LiftTranslation;

  factory LiftTranslation.fromJson(Map<String, dynamic> json) =>
      _$LiftTranslationFromJson(json);
}

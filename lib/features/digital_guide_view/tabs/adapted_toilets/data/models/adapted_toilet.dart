// ignore_for_file: invalid_annotation_target

import "package:freezed_annotation/freezed_annotation.dart";

part "adapted_toilet.freezed.dart";
part "adapted_toilet.g.dart";

@freezed
class AdaptedToilet with _$AdaptedToilet {
  const factory AdaptedToilet({
    required AdaptedToiletTranslations translations,
    @JsonKey(name: "is_access_accessible_for_pwd", fromJson: _stringToBool)
    required bool isAccessAccessibleForPwd,
  }) = _AdaptedToilet;

  factory AdaptedToilet.fromJson(Map<String, dynamic> json) =>
      _$AdaptedToiletFromJson(json);
}

@freezed
class AdaptedToiletTranslations with _$AdaptedToiletTranslations {
  const factory AdaptedToiletTranslations({
    @JsonKey(name: "pl") required AdaptedToiletTranslation plTranslation,
  }) = _AdaptedToiletTranslations;

  factory AdaptedToiletTranslations.fromJson(Map<String, dynamic> json) =>
      _$AdaptedToiletTranslationsFromJson(json);
}

@freezed
class AdaptedToiletTranslation with _$AdaptedToiletTranslation {
  const factory AdaptedToiletTranslation({
    required String location,
    @JsonKey(name: "number_of_cabins") required String numberOfCabins,
    @JsonKey(name: "is_access_accessible_for_pwd_comment")
    required String isAccessAccessibleForPwdComment,
  }) = _AdaptedToiletTranslation;

  factory AdaptedToiletTranslation.fromJson(Map<String, dynamic> json) =>
      _$AdaptedToiletTranslationFromJson(json);
}

bool _stringToBool(String str) {
  return str == "True";
}

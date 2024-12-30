// ignore_for_file: invalid_annotation_target

import "package:freezed_annotation/freezed_annotation.dart";

part "adapted_toilet_not_full.freezed.dart";
part "adapted_toilet_not_full.g.dart";

@freezed
class AdaptedToiletNotFull with _$AdaptedToiletNotFull {
  const factory AdaptedToiletNotFull({
    required AdaptedToiletTranslations translations,
    @JsonKey(name: "is_access_accessible_for_pwd", fromJson: _stringToBool)
    required bool isAccessAccessibleForPwd,
    @JsonKey(name: "has_additional_purpose", fromJson: _stringToInt)
    required int hasAdditionalPurpose,
    @JsonKey(name: "is_need_authorization") required String isNeedAuthorization,
    @JsonKey(name: "is_entrance_graphically_marked", fromJson: _stringToBool)
    required bool isEntranceGraphicallyMarked,
    @JsonKey(name: "is_marked", fromJson: _stringToBool) required bool isMarked,
    @JsonKey(name: "images") required List<int> imagesIndices,
    @JsonKey(name: "doors") required List<int> doorsIndices,
  }) = _AdaptedToiletNotFull;

  factory AdaptedToiletNotFull.fromJson(Map<String, dynamic> json) =>
      _$AdaptedToiletNotFullFromJson(json);
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
    @JsonKey(name: "toilet_description") required String toiletDescription,
    @JsonKey(name: "number_of_cabins") required String numberOfCabins,
    @JsonKey(name: "is_access_accessible_for_pwd_comment")
    required String isAccessAccessibleForPwdComment,
    @JsonKey(name: "is_need_authorization_comment")
    required String isNeedAuthorizationComment,
    @JsonKey(name: "is_area_allowing_movement_in_front_entrance_comment")
    required String isAreaAllowingMovementInFrontEntranceComment,
    @JsonKey(name: "is_entrance_graphically_marked_comment")
    required String isEntranceGraphicallyMarkedComment,
    @JsonKey(name: "is_marked_comment") required String isMarkedComment,
    required String comment,
  }) = _AdaptedToiletTranslation;

  factory AdaptedToiletTranslation.fromJson(Map<String, dynamic> json) =>
      _$AdaptedToiletTranslationFromJson(json);
}

bool _stringToBool(String str) {
  return str.toLowerCase() == "true";
}

int _stringToInt(String str) {
  return int.tryParse(str) ?? 1;
}

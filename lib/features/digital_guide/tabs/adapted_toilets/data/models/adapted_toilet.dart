import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../../utils/context_extensions.dart";
import "../../../../../../utils/type_converter.dart";

part "adapted_toilet.freezed.dart";
part "adapted_toilet.g.dart";

@freezed
class AdaptedToilet with _$AdaptedToilet {
  const factory AdaptedToilet({
    required AdaptedToiletTranslations translations,
    @JsonKey(name: "is_access_accessible_for_pwd", fromJson: stringToBool)
    required bool isAccessAccessibleForPwd,
    @JsonKey(name: "has_additional_purpose", fromJson: _stringToInt)
    required int hasAdditionalPurpose,
    @JsonKey(name: "is_need_authorization", fromJson: isNeedAuthorizationToEnum)
    required IsNeedAuthorizationEnum isNeedAuthorization,
    @JsonKey(name: "is_entrance_graphically_marked", fromJson: stringToBool)
    required bool isEntranceGraphicallyMarked,
    @JsonKey(name: "is_marked", fromJson: stringToBool) required bool isMarked,
    @JsonKey(name: "images") required IList<int> imagesIndices,
    @JsonKey(name: "doors") required IList<int> doorsIndices,
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

int _stringToInt(String str) {
  return int.tryParse(str) ?? 1;
}

IsNeedAuthorizationEnum isNeedAuthorizationToEnum(String str) {
  return switch (str.toLowerCase()) {
    "true" => IsNeedAuthorizationEnum.yes,
    "false" => IsNeedAuthorizationEnum.no,
    "unknown" => IsNeedAuthorizationEnum.unknown,
    _ => IsNeedAuthorizationEnum.unknown,
  };
}

enum IsNeedAuthorizationEnum { yes, no, unknown }

extension AdaptedToiletLocalization on AdaptedToilet {
  String getDescription(BuildContext context) {
    return switch (hasAdditionalPurpose) {
      1 => context.localize.adapted_toilet_description,
      2 => context.localize.adapted_toilet_description_men,
      3 => context.localize.adapted_toilet_description_women,
      _ => context.localize.adapted_toilet_description,
    };
  }
}

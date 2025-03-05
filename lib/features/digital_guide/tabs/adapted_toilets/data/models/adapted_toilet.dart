import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../../utils/context_extensions.dart";
import "../../../../../../utils/type_converter.dart";

part "adapted_toilet.freezed.dart";
part "adapted_toilet.g.dart";

@freezed
abstract class AdaptedToilet with _$AdaptedToilet {
  const factory AdaptedToilet({
    required AdaptedToiletTranslations translations,
    @JsonKey(name: "is_access_accessible_for_pwd", fromJson: stringToBool) required bool isAccessAccessibleForPwd,
    @JsonKey(name: "has_additional_purpose", fromJson: _stringToInt) required int hasAdditionalPurpose,
    @JsonKey(name: "is_need_authorization", fromJson: isNeedAuthorizationToEnum)
    required IsNeedAuthorizationEnum isNeedAuthorization,
    @JsonKey(name: "is_entrance_graphically_marked", fromJson: stringToBool) required bool isEntranceGraphicallyMarked,
    @JsonKey(name: "is_marked", fromJson: stringToBool) required bool isMarked,
    @JsonKey(name: "is_150x150_free_space", fromJson: stringToBool) required bool isFreeSpace,
    @JsonKey(name: "is_good_floor_wall_contrast", fromJson: stringToBool) required bool isGoodFloorWallContrast,
    @JsonKey(name: "is_side_maneuvering_space", fromJson: stringToBool) required bool isSideManeuveringSpace,
    @JsonKey(name: "is_pulldown_handle", fromJson: stringToBool) required bool isPulldownHandle,
    @JsonKey(name: "is_fixed_handle", fromJson: stringToBool) required bool isFixedHandle,
    @JsonKey(name: "is_good_pulldown_handle_wall_contrast", fromJson: stringToBool)
    required bool isGoodPulldownHandleWallContrast,
    @JsonKey(name: "is_mirror", fromJson: stringToBool) required bool isMirror,
    @JsonKey(name: "are_clothes_hooks", fromJson: stringToBool) required bool areClothesHooks,
    @JsonKey(name: "toilet_seat_height") required double toiletSeatHeight,
    @JsonKey(name: "is_wastebasket", fromJson: stringToBool) required bool isWastebasket,
    @JsonKey(name: "is_towel_dispenser", fromJson: stringToBool) required bool isTowelDispenser,
    @JsonKey(name: "is_hand_dryer", fromJson: stringToBool) required bool isHandDryer,
    @JsonKey(name: "is_space_under_washbasin_for_wheelchair", fromJson: stringToBool)
    required bool isSpaceUnderWashbasinForWheelchair,
    @JsonKey(name: "is_light_switch", fromJson: stringToBool) required bool isLightSwitch,
    @JsonKey(name: "is_good_lit", fromJson: stringToBool) required bool isGoodLit,
    @JsonKey(name: "images") required IList<int> imagesIndices,
    @JsonKey(name: "doors") required IList<int> doorsIndices,
  }) = _AdaptedToilet;

  factory AdaptedToilet.fromJson(Map<String, dynamic> json) => _$AdaptedToiletFromJson(json);
}

@freezed
abstract class AdaptedToiletTranslations with _$AdaptedToiletTranslations {
  const factory AdaptedToiletTranslations({@JsonKey(name: "pl") required AdaptedToiletTranslation plTranslation}) =
      _AdaptedToiletTranslations;

  factory AdaptedToiletTranslations.fromJson(Map<String, dynamic> json) => _$AdaptedToiletTranslationsFromJson(json);
}

@freezed
abstract class AdaptedToiletTranslation with _$AdaptedToiletTranslation {
  const factory AdaptedToiletTranslation({
    required String location,
    @JsonKey(name: "toilet_description") required String toiletDescription,
    @JsonKey(name: "number_of_cabins") required String numberOfCabins,
    @JsonKey(name: "is_access_accessible_for_pwd_comment") required String isAccessAccessibleForPwdComment,
    @JsonKey(name: "is_need_authorization_comment") required String isNeedAuthorizationComment,
    @JsonKey(name: "is_area_allowing_movement_in_front_entrance_comment")
    required String isAreaAllowingMovementInFrontEntranceComment,
    @JsonKey(name: "is_entrance_graphically_marked_comment") required String isEntranceGraphicallyMarkedComment,
    @JsonKey(name: "is_marked_comment") required String isMarkedComment,
    @JsonKey(name: "toilet_dimensions") required String toiletDimensions,
    @JsonKey(name: "is_150x150_free_space_comment") required String is150x150FreeSpaceComment,
    @JsonKey(name: "is_good_floor_wall_contrast_comment") required String isGoodFloorWallContrastComment,
    @JsonKey(name: "is_side_maneuvering_space_comment") required String isSideManeuveringSpaceComment,
    @JsonKey(name: "is_pulldown_handle_comment") required String isPulldownHandleComment,
    @JsonKey(name: "is_fixed_handle_comment") required String isFixedHandleComment,
    @JsonKey(name: "is_good_pulldown_handle_wall_contrast_comment")
    required String isGoodPulldownHandleWallContrastComment,
    @JsonKey(name: "is_mirror_comment") required String isMirrorComment,
    @JsonKey(name: "are_clothes_hooks_comment") required String areClothesHooksComment,
    @JsonKey(name: "is_wastebasket_comment") required String isWastebasketComment,
    @JsonKey(name: "is_towel_dispenser_comment") required String isTowelDispenserComment,
    @JsonKey(name: "is_hand_dryer_comment") required String isHandDryerComment,
    @JsonKey(name: "washbasin_location_height") required String washbasinLocationHeight,
    @JsonKey(name: "is_space_under_washbasin_for_wheelchair_comment")
    required String isSpaceUnderWashbasinForWheelchairComment,
    @JsonKey(name: "is_light_switch_comment") required String isLightSwitchComment,
    @JsonKey(name: "is_good_lit_comment") required String isGoodLitComment,
    required String comment,
  }) = _AdaptedToiletTranslation;

  factory AdaptedToiletTranslation.fromJson(Map<String, dynamic> json) => _$AdaptedToiletTranslationFromJson(json);
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

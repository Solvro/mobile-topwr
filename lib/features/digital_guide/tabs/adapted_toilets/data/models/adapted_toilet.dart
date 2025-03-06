import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../../utils/context_extensions.dart";
import "../../../../../../utils/type_converter.dart";

part "adapted_toilet.freezed.dart";
part "adapted_toilet.g.dart";

@freezed
abstract class AdaptedToilet with _$AdaptedToilet {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AdaptedToilet({
    required AdaptedToiletTranslations translations,
    @JsonKey(fromJson: stringToBool) required bool isAccessAccessibleForPwd,
    @JsonKey(fromJson: _stringToInt) required int hasAdditionalPurpose,
    @JsonKey(fromJson: isNeedAuthorizationToEnum) required IsNeedAuthorizationEnum isNeedAuthorization,
    @JsonKey(fromJson: stringToBool) required bool isEntranceGraphicallyMarked,
    @JsonKey(fromJson: stringToBool) required bool isMarked,
    @JsonKey(name: "is_150x150_free_space", fromJson: stringToBool) required bool isFreeSpace,
    @JsonKey(fromJson: stringToBool) required bool isGoodFloorWallContrast,
    @JsonKey(fromJson: stringToBool) required bool isSideManeuveringSpace,
    @JsonKey(fromJson: stringToBool) required bool isPulldownHandle,
    @JsonKey(fromJson: stringToBool) required bool isFixedHandle,
    @JsonKey(fromJson: stringToBool) required bool isGoodPulldownHandleWallContrast,
    @JsonKey(fromJson: stringToBool) required bool isMirror,
    @JsonKey(fromJson: stringToBool) required bool areClothesHooks,
    required double toiletSeatHeight,
    @JsonKey(fromJson: stringToBool) required bool isWastebasket,
    @JsonKey(fromJson: stringToBool) required bool isTowelDispenser,
    @JsonKey(fromJson: stringToBool) required bool isHandDryer,
    @JsonKey(fromJson: stringToBool) required bool isSpaceUnderWashbasinForWheelchair,
    @JsonKey(fromJson: stringToBool) required bool isLightSwitch,
    @JsonKey(fromJson: stringToBool) required bool isGoodLit,
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
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AdaptedToiletTranslation({
    required String location,
    required String toiletDescription,
    required String numberOfCabins,
    required String isAccessAccessibleForPwdComment,
    required String isNeedAuthorizationComment,
    required String isAreaAllowingMovementInFrontEntranceComment,
    required String isEntranceGraphicallyMarkedComment,
    required String isMarkedComment,
    required String toiletDimensions,
    @JsonKey(name: "is_150x150_free_space_comment") required String isFreeSpaceComment,
    required String isGoodFloorWallContrastComment,
    required String isSideManeuveringSpaceComment,
    required String isPulldownHandleComment,
    required String isFixedHandleComment,
    required String isGoodPulldownHandleWallContrastComment,
    required String isMirrorComment,
    required String areClothesHooksComment,
    required String isWastebasketComment,
    required String isTowelDispenserComment,
    required String isHandDryerComment,
    required String washbasinLocationHeight,
    required String isSpaceUnderWashbasinForWheelchairComment,
    required String isLightSwitchComment,
    required String isGoodLitComment,
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

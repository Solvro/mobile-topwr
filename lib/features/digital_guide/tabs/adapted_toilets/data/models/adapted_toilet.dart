import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

import "../../../../../../utils/context_extensions.dart";
import "../../../../../../utils/type_converter.dart";

part "adapted_toilet.freezed.dart";
part "adapted_toilet.g.dart";
part "adapted_toilet.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class AdaptedToilet with _$AdaptedToilet, _$AdaptedToiletTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AdaptedToilet({
    required AdaptedToiletTranslations translations,
    required String isAccessAccessibleForPwd,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int hasAdditionalPurpose,
    required String isNeedAuthorization,
    required String isEntranceGraphicallyMarked,
    required String isMarked,
    @JsonKey(name: "is_150x150_free_space") required String isFreeSpace,
    required String isGoodFloorWallContrast,
    required String isSideManeuveringSpace,
    required String isPulldownHandle,
    required String isFixedHandle,
    required String isGoodPulldownHandleWallContrast,
    required String isMirror,
    required String areClothesHooks,
    required double toiletSeatHeight,
    required String isWastebasket,
    required String isTowelDispenser,
    required String isHandDryer,
    required String isSpaceUnderWashbasinForWheelchair,
    required String isLightSwitch,
    required String isGoodLit,
    @JsonKey(name: "images") required IList<int> imagesIndices,
    @JsonKey(name: "doors") required IList<int> doorsIndices,
  }) = _AdaptedToilet;

  const AdaptedToilet._();

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

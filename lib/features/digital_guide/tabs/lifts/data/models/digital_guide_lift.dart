import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../../services/translations_service/data/models/translatable.dart";

part "digital_guide_lift.freezed.dart";

part "digital_guide_lift.g.dart";

@freezed
abstract class DigitalGuideLift with _$DigitalGuideLift implements Translatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideLift({
    required int id,
    required DigitalGuideTranslationsLift translations,
    @JsonKey(name: "images") required List<int>? imagesIds,
    required String displayInLiftsCategory,
    required String isMarkedFromEntrance,
    required String isMarkedFromEntranceInEn,
    @JsonKey(fromJson: int.tryParse) required int? isUsedBy,
    required String isSigned,
    required String isSignedInEn,
    required String isFloorMarked,
    required String isGlazed,
    required int doorWidth,
    required String isOpenAutomatically,
    @JsonKey(fromJson: int.tryParse) required int? doorType,
    required String isIncreasedForceRequired,
    required String isTwoSided,
    required String isMirror,
    required String isDisplayFloorInformation,
    required String isVoicePrompts,
    required String isVoicePromptsInEn,
    required String isControlPanelTouchscreen,
    required String isInsideButtonBraille,
    required String isInsideButtonBrailleMarked,
    required String isInsideConvexButton,
    required String isOutsideButtonBraille,
    required String isOutsideButtonBrailleMarked,
    required String isOutsideConvexButton,
    required int insideControlPanelHeight,
    required int outsideControlPanelHeight,
    required String isInsideLit,
    required String isRailing,
    required String isAlarmButton,
    required String isDisplayShowingFloor,
    required String isOutsideArrivalNotificationSound,
    required String isInsideArrivalNotificationSound,
    required String isGoodDoorWallContrast,
  }) = _DigitalGuideLift;

  factory DigitalGuideLift.fromJson(Map<String, dynamic> json) => _$DigitalGuideLiftFromJson(json);
}

@freezed
abstract class DigitalGuideTranslationsLift with _$DigitalGuideTranslationsLift {
  const factory DigitalGuideTranslationsLift({required DigitalGuideTranslationLift pl}) = _DigitalGuideTranslationsLift;

  factory DigitalGuideTranslationsLift.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsLiftFromJson(json);
}

@freezed
abstract class DigitalGuideTranslationLift with _$DigitalGuideTranslationLift {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationLift({
    required String location,
    required String floorsList,
    required String maximumLiftCapacity,
    required String liftDimensions,
    required String isRailingComment,
  }) = _DigitalGuideTranslationLift;

  factory DigitalGuideTranslationLift.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationLiftFromJson(json);
}

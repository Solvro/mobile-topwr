import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

import "../../../../../../utils/type_converter.dart";

part "digital_guide_lift.freezed.dart";
part "digital_guide_lift.g.dart";
part "digital_guide_lift.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DigitalGuideLift with _$DigitalGuideLift, _$DigitalGuideLiftTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideLift({
    required int id,
    @translatableField required DigitalGuideTranslationsLift translations,
    @JsonKey(name: "images") required List<int>? imagesIds,
    required String displayInLiftsCategory,
    required String isMarkedFromEntrance,
    required String isMarkedFromEntranceInEn,
    @JsonKey(fromJson: int.tryParse, toJson: maybeIntToString) required int? isUsedBy,
    required String isSigned,
    required String isSignedInEn,
    required String isFloorMarked,
    required String isGlazed,
    required int doorWidth,
    required String isOpenAutomatically,
    @JsonKey(fromJson: int.tryParse, toJson: maybeIntToString) required int? doorType,
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

  const DigitalGuideLift._();

  factory DigitalGuideLift.fromJson(Map<String, dynamic> json) => _$DigitalGuideLiftFromJson(json);
}

@freezed
abstract class DigitalGuideTranslationsLift with _$DigitalGuideTranslationsLift {
  const factory DigitalGuideTranslationsLift({@translatableField required DigitalGuideTranslationLift pl}) =
      _DigitalGuideTranslationsLift;

  factory DigitalGuideTranslationsLift.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsLiftFromJson(json);
}

@freezed
abstract class DigitalGuideTranslationLift with _$DigitalGuideTranslationLift {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationLift({
    @translatableField required String location,
    @translatableField required String floorsList,
    @translatableField required String maximumLiftCapacity,
    @translatableField required String liftDimensions,
    required String isRailingComment,
  }) = _DigitalGuideTranslationLift;

  factory DigitalGuideTranslationLift.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationLiftFromJson(json);
}

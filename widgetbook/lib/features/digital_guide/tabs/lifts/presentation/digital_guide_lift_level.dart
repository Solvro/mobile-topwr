import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/data/models/level.dart";
import "package:topwr/features/digital_guide/tabs/lifts/data/models/digital_guide_lift.dart";
import "package:topwr/features/digital_guide/tabs/lifts/presentation/digital_guide_lift_level.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockLift = DigitalGuideLift(
  id: 1,
  translations: DigitalGuideTranslationsLift(
    pl: DigitalGuideTranslationLift(
      location: "Hall A",
      floorsList: "1,2,3",
      liftDimensions: "100x200cm",
      maximumLiftCapacity: "10 persons",
      isRailingComment: "New and reliable",
    ),
  ),
  imagesIds: [101],
  displayInLiftsCategory: "yes",
  isMarkedFromEntrance: "yes",
  isMarkedFromEntranceInEn: "yes",
  isUsedBy: 3,
  isSigned: "yes",
  isSignedInEn: "yes",
  isFloorMarked: "yes",
  isGlazed: "no",
  doorWidth: 90,
  isOpenAutomatically: "yes",
  doorType: 1,
  isIncreasedForceRequired: "no",
  isTwoSided: "no",
  isMirror: "yes",
  isDisplayFloorInformation: "yes",
  isVoicePrompts: "yes",
  isVoicePromptsInEn: "yes",
  isControlPanelTouchscreen: "no",
  isInsideButtonBraille: "no",
  isInsideButtonBrailleMarked: "no",
  isInsideConvexButton: "no",
  isOutsideButtonBraille: "no",
  isOutsideButtonBrailleMarked: "no",
  isOutsideConvexButton: "no",
  insideControlPanelHeight: 110,
  outsideControlPanelHeight: 100,
  isInsideLit: "yes",
  isRailing: "yes",
  isAlarmButton: "yes",
  isDisplayShowingFloor: "yes",
  isOutsideArrivalNotificationSound: "yes",
  isInsideArrivalNotificationSound: "yes",
  isGoodDoorWallContrast: "yes",
);

final _mockLifts = IList(const [_mockLift, _mockLift]);
const _mockLevel = Level(
  id: 1,
  floorNumber: 0,
  translations: LevelTranslations(
    plTranslation: LevelTranslation(name: "Ground Floor", roomNumbersRange: "100-150"),
  ),
  regionIndices: [1],
);

@widgetbook.UseCase(name: "default", type: DigitalGuideLiftLevel)
Widget useCaseDigitalGuideLiftLevel(BuildContext context) {
  return DigitalGuideLiftLevel(level: _mockLevel, lifts: _mockLifts);
}

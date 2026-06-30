import "package:topwr/features/digital_guide/tabs/lifts/data/models/digital_guide_lift.dart";
import "package:topwr/features/digital_guide/tabs/lifts/presentation/digital_guide_lift_detail_view.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_lift_detail_view.stories.g.dart";

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
  imagesIds: [101, 102],
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

const meta = Meta(DigitalGuideLiftDetailView.new);

final $default = DigitalGuideLiftDetailViewStory(args: DigitalGuideLiftDetailViewArgs(lift: Arg.fixed(_mockLift)));

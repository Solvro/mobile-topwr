import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/data/models/level.dart";
import "package:topwr/features/digital_guide/tabs/lifts/data/models/digital_guide_lift.dart";
import "package:topwr/features/digital_guide/tabs/lifts/domain/digital_guide_lifts_use_cases.dart";
import "package:topwr/features/digital_guide/tabs/lifts/presentation/digital_guide_lifts_expansion_tile_content.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_lift_expansion_tile_content.stories.g.dart";

const _mockDigitalGuideData = DigitalGuideResponse(
  id: 1,
  externalId: 100,
  translations: DigitalGuideTranslations(
    plTranslation: DigitalGuideTranslation(
      name: "Building A",
      extendedName: "Main Academic Building",
      address: "Wyb. Wyspiańskiego 23-25, 50-370 Wrocław",
      evacuationDescription: "Use main stairs",
    ),
  ),
  numberOfStoreys: 5,
  canAssistanceDog: true,
  isInductionLoop: true,
  isMicroNavigationSystem: false,
  areGuidancePaths: true,
  areBrailleBoards: true,
  areLargeFontBoards: true,
  isSignLanguageInterpreter: false,
  areEmergencyChairs: true,
  phoneNumbers: ["123456789"],
  surroundingId: 1,
  images: [1, 2, 3],
  evacuationMapId: 1,
  locationMapId: 1,
  levelsIndices: [0, 1, 2, 3, 4],
  accessId: 1,
  accessibilityLevelForMotorDisability: 1,
  accessibilityLevelForBlind: 2,
  accessibilityLevelForVisuallyImpaired: 2,
  accessibilityLevelForHardOfHearing: 1,
  accessibilityLevelForHighSensorySensitivity: 1,
  accessibilityLevelForCognitiveDifficulties: 1,
);

const meta = Meta<DigitalGuideLiftExpansionTileContent>();

const _mockLift = DigitalGuideLift(
  id: 1,
  translations: DigitalGuideTranslationsLift(
    pl: DigitalGuideTranslationLift(
      location: "Hall A",
      floorsList: "0,1,2",
      liftDimensions: "100x200 cm",
      maximumLiftCapacity: "10 persons",
      isRailingComment: "Railing on one side",
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

const _mockLevel = Level(
  id: 1,
  floorNumber: 0,
  translations: LevelTranslations(
    plTranslation: LevelTranslation(name: "Ground floor", roomNumbersRange: "001-050"),
  ),
  regionIndices: [1],
);

final $default = DigitalGuideLiftExpansionTileContentStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [
      getLevelWithLiftsUseCaseProvider.overrideWith(
        (ref, digitalGuideData) async => IListConst(const [
          (level: _mockLevel, lifts: IListConst([_mockLift, _mockLift])),
        ]),
      ),
    ],
    child: child,
  ),
  args: DigitalGuideLiftExpansionTileContentArgs(digitalGuideResponse: Arg.fixed(_mockDigitalGuideData)),
);

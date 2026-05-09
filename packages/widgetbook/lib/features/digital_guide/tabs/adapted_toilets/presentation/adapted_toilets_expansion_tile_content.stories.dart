import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/data/models/level.dart";
import "package:topwr/features/digital_guide/tabs/adapted_toilets/business/adapted_toilets_use_cases.dart";
import "package:topwr/features/digital_guide/tabs/adapted_toilets/data/models/adapted_toilet.dart";
import "package:topwr/features/digital_guide/tabs/adapted_toilets/presentation/adapted_toilets_expansion_tile_content.dart";
import "package:widgetbook/widgetbook.dart";

part "adapted_toilets_expansion_tile_content.stories.g.dart";

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

const meta = Meta<AdaptedToiletsExpansionTileContent>();

const _mockToilet = AdaptedToilet(
  translations: AdaptedToiletTranslations(
    plTranslation: AdaptedToiletTranslation(
      location: "Ground floor next to reception",
      toiletDescription: "Adapted toilet",
      numberOfCabins: "1",
      isAccessAccessibleForPwdComment: "Accessible without stairs",
      isNeedAuthorizationComment: "No authorization needed",
      isAreaAllowingMovementInFrontEntranceComment: "Enough maneuvering space",
      isEntranceGraphicallyMarkedComment: "Clear signage",
      isMarkedComment: "Marked",
      toiletDimensions: "200x220 cm",
      isFreeSpaceComment: "Sufficient turning area",
      isGoodFloorWallContrastComment: "Good contrast",
      isSideManeuveringSpaceComment: "Available",
      isPulldownHandleComment: "Installed",
      isFixedHandleComment: "Installed",
      isGoodPulldownHandleWallContrastComment: "Good contrast",
      isMirrorComment: "At accessible height",
      areClothesHooksComment: "Available",
      isWastebasketComment: "Available",
      isTowelDispenserComment: "Available",
      isHandDryerComment: "Available",
      washbasinLocationHeight: "80 cm",
      isSpaceUnderWashbasinForWheelchairComment: "Enough space",
      isLightSwitchComment: "At reachable height",
      isGoodLitComment: "Well lit",
      comment: "Near elevator",
    ),
  ),
  isAccessAccessibleForPwd: "yes",
  hasAdditionalPurpose: 1,
  isNeedAuthorization: "no",
  isEntranceGraphicallyMarked: "yes",
  isMarked: "yes",
  isFreeSpace: "yes",
  isGoodFloorWallContrast: "yes",
  isSideManeuveringSpace: "yes",
  isPulldownHandle: "yes",
  isFixedHandle: "yes",
  isGoodPulldownHandleWallContrast: "yes",
  isMirror: "yes",
  areClothesHooks: "yes",
  toiletSeatHeight: 48,
  isWastebasket: "yes",
  isTowelDispenser: "yes",
  isHandDryer: "yes",
  isSpaceUnderWashbasinForWheelchair: "yes",
  isLightSwitch: "yes",
  isGoodLit: "yes",
  imagesIndices: IListConst([]),
  doorsIndices: IListConst([]),
);

const _mockLevel = Level(
  id: 1,
  floorNumber: 0,
  translations: LevelTranslations(
    plTranslation: LevelTranslation(name: "Ground floor", roomNumbersRange: "001-050"),
  ),
  regionIndices: [1],
);

final $default = AdaptedToiletsExpansionTileContentStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [
      getLevelsWithToiletsUseCaseProvider.overrideWith(
        (ref, digitalGuideData) => const IListConst([
          (level: _mockLevel, adaptedToilets: IListConst([_mockToilet])),
        ]),
      ),
    ],
    child: child,
  ),
  args: AdaptedToiletsExpansionTileContentArgs(digitalGuideData: Arg.fixed(_mockDigitalGuideData)),
);

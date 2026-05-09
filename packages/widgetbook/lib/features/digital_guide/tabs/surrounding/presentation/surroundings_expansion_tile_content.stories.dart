import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/tabs/surrounding/data/models/surrounding_response.dart";
import "package:topwr/features/digital_guide/tabs/surrounding/data/repository/surrounding_repository.dart";
import "package:topwr/features/digital_guide/tabs/surrounding/presentation/surroundings_expansion_tile_content.dart";
import "package:widgetbook/widgetbook.dart";

part "surroundings_expansion_tile_content.stories.g.dart";

const _mockDigitalGuideData = DigitalGuideResponse(
  id: 1,
  externalId: 313,
  translations: DigitalGuideTranslations(
    plTranslation: DigitalGuideTranslation(
      name: "Building A",
      extendedName: "Main Building",
      address: "ul. Testowa 1",
      evacuationDescription: "Evacuation route via main entrance",
    ),
  ),
  numberOfStoreys: 3,
  canAssistanceDog: true,
  isInductionLoop: true,
  isMicroNavigationSystem: true,
  areGuidancePaths: true,
  areBrailleBoards: true,
  areLargeFontBoards: true,
  isSignLanguageInterpreter: false,
  areEmergencyChairs: true,
  phoneNumbers: ["123456789"],
  surroundingId: 1,
  images: [1, 2],
  evacuationMapId: 1,
  locationMapId: 1,
  levelsIndices: [0, 1, 2],
  accessId: 1,
  accessibilityLevelForMotorDisability: 1,
  accessibilityLevelForBlind: 1,
  accessibilityLevelForVisuallyImpaired: 1,
  accessibilityLevelForHardOfHearing: 1,
  accessibilityLevelForHighSensorySensitivity: 1,
  accessibilityLevelForCognitiveDifficulties: 1,
);

const meta = Meta<SurroundingsExpansionTileContent>();

const _mockSurroundingResponse = SurroundingResponse(
  id: 1,
  translations: SurroundingResponseTranslations(
    plTranslation: SurroundingResponseTranslationsDetails(
      areNoBarriersComment: "Paths are mostly barrier-free.",
      areLoweredCurbsComment: "Lowered curbs are available.",
      isPavementRoughComment: "Surface is even.",
      areParkingSpacesComment: "Public parking nearby.",
      areParkingSpacesForPwdComment: "Dedicated spaces present.",
      areHighCurbsAtParkingSpaceForPwdComment: "No high curbs near PWD spaces.",
      closestBuildings: "C-13, C-14",
      isPathToAccessibleEntranceMarkedComment: "Accessible path is marked.",
      areDangerousElementsComment: "No major dangerous elements.",
      isLitComment: "Area is well lit at night.",
      isNoisyStreetNearBuildingComment: "Moderate city noise.",
      isSidewalkSeparatedFromTheRoadComment: "Sidewalk separated from road traffic.",
      accessibilityLevelForMotorDisabilityComment: "Good access.",
      accessibilityLevelForBlindComment: "Moderate access.",
      accessibilityLevelForVisuallyImpairedComment: "Moderate access.",
      accessibilityLevelForHardOfHearingComment: "Good access.",
      accessibilityLevelForHighSensorySensitivityComment: "Moderate access.",
      accessibilityLevelForCognitiveDifficultiesComment: "Moderate access.",
      comment: "Surroundings are generally accessible.",
    ),
  ),
  areNoBarriers: "yes",
  areLoweredCurbs: "yes",
  isPavementRough: "no",
  areParkingSpaces: "yes",
  areParkingSpacesForPwd: "yes",
  areHighCurbsAtParkingSpaceForPwd: "no",
  isPathToAccessibleEntranceMarked: "yes",
  areDangerousElements: "no",
  isLit: "yes",
  isNoisyStreetNearBuilding: "yes",
  isSidewalkSeparatedFromTheRoad: "yes",
  accessibilityLevelForMotorDisability: 1,
  accessibilityLevelForBlind: 2,
  accessibilityLevelForVisuallyImpaired: 2,
  accessibilityLevelForHardOfHearing: 1,
  accessibilityLevelForHighSensorySensitivity: 2,
  accessibilityLevelForCognitiveDifficulties: 2,
  building: 1,
  images: [],
);

final $default = SurroundingsExpansionTileContentStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [surroundingRepositoryProvider(args.digitalGuideData).overrideWith((ref) => _mockSurroundingResponse)],
    child: child,
  ),
  args: SurroundingsExpansionTileContentArgs(digitalGuideData: Arg.fixed(_mockDigitalGuideData)),
);

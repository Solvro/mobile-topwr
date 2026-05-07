import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
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

final $default = SurroundingsExpansionTileContentStory(
  args: SurroundingsExpansionTileContentArgs(digitalGuideData: Arg.fixed(_mockDigitalGuideData)),
);

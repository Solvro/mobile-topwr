import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/tabs/dressing_room/presentation/digital_guide_dressing_rooms_expansion_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_dressing_rooms_expansion_tile_content.stories.g.dart";

const mockDigitalGuideResponse = DigitalGuideResponse(
  id: 1,
  externalId: 123,
  translations: DigitalGuideTranslations(
    plTranslation: DigitalGuideTranslation(
      name: "C-13 Serowiec",
      extendedName: "Budynek C-13 Politechniki Wrocławskiej",
      address: "Wyb. Wyspiańskiego 23-25, 50-370 Wrocław",
      evacuationDescription: "Kieruj się oznaczeniami ewakuacyjnymi do najbliższej klatki schodowej.",
    ),
  ),
  numberOfStoreys: 3,
  canAssistanceDog: false,
  isInductionLoop: false,
  isMicroNavigationSystem: false,
  areGuidancePaths: false,
  areBrailleBoards: false,
  areLargeFontBoards: false,
  isSignLanguageInterpreter: false,
  areEmergencyChairs: false,
  phoneNumbers: ["111222333"],
  surroundingId: 42,
  images: [],
  evacuationMapId: 1,
  locationMapId: 2,
  levelsIndices: [],
  accessId: 1,
  accessibilityLevelForMotorDisability: 0,
  accessibilityLevelForBlind: 0,
  accessibilityLevelForVisuallyImpaired: 0,
  accessibilityLevelForHardOfHearing: 0,
  accessibilityLevelForHighSensorySensitivity: 0,
  accessibilityLevelForCognitiveDifficulties: 0,
);

const meta = Meta<DigitalGuideDressingRoomsExpansionTileContent>();

final $defaultMock = DigitalGuideDressingRoomsExpansionTileContentStory(
  args: DigitalGuideDressingRoomsExpansionTileContentArgs(digitalGuideResponse: Arg.fixed(mockDigitalGuideResponse)),
);

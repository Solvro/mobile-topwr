import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/tabs/localization/presentation/localization_expansion_tile_content.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../../../widgetbook_placeholders.dart";

part "localization_expansion_tile_content.stories.g.dart";

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
  images: [1, 2, 3],
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

const _mockBuilding = Building(
  rawId: 1,
  name: "building_a",
  naturalName: "Building A",
  addressLine1: "ul. Testowa 1",
  addressLine2: "50-370 Wrocław",
  latitude: 51.1079,
  longitude: 17.0385,
  externalDigitalGuideMode: ExternalDigitalGuideMode.digitalGuideBuilding,
  externalDigitalGuideIdOrUrl: "313",
  cover: ImageData(url: widgetbookPlaceholderImageUrl),
  branch: Branch.main,
);

const meta = Meta(LocalizationExpansionTileContent.new);

final $default = LocalizationExpansionTileContentStory(
  args: LocalizationExpansionTileContentArgs(
    digitalGuideData: Arg.fixed(_mockDigitalGuideData),
    building: Arg.fixed(_mockBuilding),
  ),
);

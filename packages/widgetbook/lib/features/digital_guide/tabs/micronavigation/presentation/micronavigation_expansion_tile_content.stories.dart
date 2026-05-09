import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/tabs/micronavigation/data/models/micronavigation_response.dart";
import "package:topwr/features/digital_guide/tabs/micronavigation/data/repository/micronavigation_repository.dart";
import "package:topwr/features/digital_guide/tabs/micronavigation/presentation/micronavigation_expansion_tile_content.dart";
import "package:widgetbook/widgetbook.dart";

part "micronavigation_expansion_tile_content.stories.g.dart";

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

const meta = Meta<MicronavigationExpansionTileContent>();

const _mockMicronavigationResponse = MicronavigationResponse(
  id: 1,
  location: 100,
  nameOverride: MicronavigationTranslations(pl: "Main route", en: "Main route"),
  webContent: MicronavigationTranslations(pl: "Directions", en: "Directions"),
  languages: [
    MicronavigationLanguage(id: 1, langCode: "en", text: "English content", order: 1),
    MicronavigationLanguage(id: 2, langCode: "pl", text: "Polska tresc", order: 2),
  ],
);

final $default = MicronavigationExpansionTileContentStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [
      getMicronavigationDataProvider.overrideWith((ref, id) => const IListConst([_mockMicronavigationResponse])),
    ],
    child: child,
  ),
  args: MicronavigationExpansionTileContentArgs(digitalGuideData: Arg.fixed(_mockDigitalGuideData)),
);

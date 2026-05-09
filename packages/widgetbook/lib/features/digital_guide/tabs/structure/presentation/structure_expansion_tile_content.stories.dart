import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/data/models/level.dart";
import "package:topwr/features/digital_guide/data/models/region.dart";
import "package:topwr/features/digital_guide/data/repository/levels_repository.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/structure_expansion_tile_content.dart";
import "package:widgetbook/widgetbook.dart";

part "structure_expansion_tile_content.stories.g.dart";

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

const meta = Meta<StructureExpansionTileContent>();

const _mockLevel = Level(
  id: 1,
  floorNumber: 0,
  translations: LevelTranslations(
    plTranslation: LevelTranslation(name: "Ground floor", roomNumbersRange: "001-050"),
  ),
  regionIndices: [1],
);

const _mockRegion = Region(
  translations: RegionTranslations(
    plTranslation: RegionTranslation(name: "Main hall", location: "North wing"),
  ),
  dressingRooms: [],
  lodges: [],
  informationPoints: [],
  toilets: [1],
  adaptedToilets: [1],
  lifts: [1],
  stairs: [1],
  ramps: [],
  corridors: [1],
  stairways: [],
  rooms: [101, 102],
  parkings: [],
  accessibilityLevelForMotorDisability: 2,
  accessibilityLevelForBlind: 2,
  accessibilityLevelForVisuallyImpaired: 2,
  accessibilityLevelForHardOfHearing: 2,
  accessibilityLevelForHighSensorySensitivity: 2,
  accessibilityLevelForCognitiveDifficulties: 2,
);

final $default = StructureExpansionTileContentStory(
  setup: (context, child, args) => ProviderScope(
    key: ValueKey("structure-${args.digitalGuideData.id}"),
    overrides: [
      levelsWithRegionsRepositoryProvider.overrideWith(
        (ref, digitalGuideData) => const IListConst([
          (level: _mockLevel, regions: IListConst([_mockRegion])),
        ]),
      ),
    ],
    child: child,
  ),
  args: StructureExpansionTileContentArgs(digitalGuideData: Arg.fixed(_mockDigitalGuideData)),
);

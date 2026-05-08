import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/data/models/optional_tiles_data.dart";
import "package:topwr/features/digital_guide/data/repository/levels_repository.dart";
import "package:topwr/features/digital_guide/data/repository/optional_tiles_data_repository.dart";
import "package:topwr/features/digital_guide/presentation/widgets/digital_guide_features_section.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_features_section.stories.g.dart";

const _mockDigitalGuideData = DigitalGuideResponse(
  id: 1,
  externalId: 100,
  translations: DigitalGuideTranslations(
    plTranslation: DigitalGuideTranslation(
      name: "C-13 Serowiec",
      extendedName: "Budynek C-13 Politechniki Wrocławskiej",
      address: "Wyb. Wyspiańskiego 23-25, 50-370 Wrocław",
      evacuationDescription: "Kieruj się oznaczeniami ewakuacyjnymi do najbliższej klatki schodowej.",
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

const _mockBuilding = Building(
  rawId: 1,
  name: "C-13",
  naturalName: "Serowiec",
  addressLine1: "Wyb. Wyspiańskiego 23-25",
  addressLine2: "50-370 Wrocław",
  latitude: 51.107546,
  longitude: 17.059038,
  externalDigitalGuideMode: ExternalDigitalGuideMode.digitalGuideBuilding,
  externalDigitalGuideIdOrUrl: "313",
  cover: ImageData(url: "https://placehold.co/1200x800/png?text=C13+Serowiec"),
  branch: Branch.main,
);

const meta = Meta<DigitalGuideFeaturesSection>();

final $default = DigitalGuideFeaturesSectionStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [
      levelsWithRegionsRepositoryProvider(args.digitalGuideData).overrideWith((ref) async => IListConst(const [])),
      optionalTilesDataRepositoryProvider(
        args.digitalGuideData.id,
      ).overrideWith((ref) async => const OptionalTilesData()),
    ],
    child: CustomScrollView(slivers: [child]),
  ),
  args: DigitalGuideFeaturesSectionArgs(
    digitalGuideData: Arg.fixed(_mockDigitalGuideData),
    building: Arg.fixed(_mockBuilding),
  ),
);

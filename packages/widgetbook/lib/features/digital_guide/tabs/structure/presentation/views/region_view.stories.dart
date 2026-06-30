import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/level.dart";
import "package:topwr/features/digital_guide/data/models/region.dart";
import "package:topwr/features/digital_guide/tabs/dressing_room/data/models/digital_guide_dressing_room.dart";
import "package:topwr/features/digital_guide/tabs/information_points/models/digital_guide_information_points.dart";
import "package:topwr/features/digital_guide/tabs/lifts/data/models/digital_guide_lift.dart";
import "package:topwr/features/digital_guide/tabs/lodge/data/models/digital_guide_lodge.dart";
import "package:topwr/features/digital_guide/tabs/rooms/data/models/digital_guide_room.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/corridor.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/parking.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/ramp.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/stairs.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/stairway.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/toilet.dart";
import "package:topwr/features/digital_guide/tabs/structure/domain/digital_guide_region_use_cases.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/region_view.dart";
import "package:widgetbook/widgetbook.dart";

part "region_view.stories.g.dart";

const _mockLevel = Level(
  id: 1,
  floorNumber: 0,
  translations: LevelTranslations(
    plTranslation: LevelTranslation(name: "Ground Floor", roomNumbersRange: "100-150"),
  ),
  regionIndices: [1],
);

const _mockRegion = Region(
  translations: RegionTranslations(
    plTranslation: RegionTranslation(name: "Region A", location: "Main building"),
  ),
  dressingRooms: [],
  lodges: [],
  informationPoints: [],
  toilets: [],
  adaptedToilets: [],
  lifts: [],
  stairs: [],
  ramps: [],
  corridors: [],
  stairways: [],
  rooms: [],
  parkings: [],
  accessibilityLevelForMotorDisability: 0,
  accessibilityLevelForBlind: 0,
  accessibilityLevelForVisuallyImpaired: 0,
  accessibilityLevelForHardOfHearing: 0,
  accessibilityLevelForHighSensorySensitivity: 0,
  accessibilityLevelForCognitiveDifficulties: 0,
);

const meta = Meta(RegionView.new);

final $default = RegionViewStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [
      digitalGuideRegionUseCasesProvider(args.region).overrideWith(
        (ref) => (
          corridors: const IListConst<Corridor>([]),
          stairs: const IListConst<Stairs>([]),
          ramps: const IListConst<Ramp>([]),
          stairways: const IListConst<Stairway>([]),
          lifts: const IListConst<DigitalGuideLift>([]),
          lodges: const IListConst<DigitalGuideLodge>([]),
          informationPoints: const IListConst<DigitalGuideInformationPoint>([]),
          dressingRooms: const IListConst<DigitalGuideDressingRoom>([]),
          toilets: const IListConst<Toilet>([]),
          rooms: const IListConst<DigitalGuideRoom>([]),
          parkings: const IListConst<DigitalGuideParking>([]),
        ),
      ),
    ],
    child: child,
  ),
  args: RegionViewArgs(level: Arg.fixed(_mockLevel), region: Arg.fixed(_mockRegion)),
);

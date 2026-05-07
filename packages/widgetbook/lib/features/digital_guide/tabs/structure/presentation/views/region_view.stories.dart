import "package:topwr/features/digital_guide/data/models/level.dart";
import "package:topwr/features/digital_guide/data/models/region.dart";
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

const meta = Meta<RegionView>();

final $default = RegionViewStory(
  args: RegionViewArgs(level: Arg.fixed(_mockLevel), region: Arg.fixed(_mockRegion)),
);

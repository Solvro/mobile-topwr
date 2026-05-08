import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/building_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "building_tile.stories.g.dart";

const _mockBuildingWithPlaceholderPhoto = Building(
  rawId: 1,
  name: "Main Building",
  naturalName: "Main Campus Building",
  addressLine1: "123 University Street",
  addressLine2: "Building A",
  latitude: 51.1079,
  longitude: 17.0385,
  externalDigitalGuideMode: ExternalDigitalGuideMode.digitalGuideBuilding,
  externalDigitalGuideIdOrUrl: "313",
  cover: ImageData(url: "https://placehold.co/1200x800/png?text=C13+Serowiec"),
  branch: Branch.main,
);

const _mockBuildingWithoutPhoto = Building(
  rawId: 1,
  name: "Main Building",
  naturalName: "Main Campus Building",
  addressLine1: "123 University Street",
  addressLine2: "Building A",
  latitude: 51.1079,
  longitude: 17.0385,
  externalDigitalGuideMode: ExternalDigitalGuideMode.digitalGuideBuilding,
  externalDigitalGuideIdOrUrl: "313",
  cover: null,
  branch: Branch.main,
);

const meta = Meta<BuildingTile>();

final $withPlaceholderPhoto = BuildingTileStory(
  name: "With placeholder photo",
  args: BuildingTileArgs(building: Arg.fixed(_mockBuildingWithPlaceholderPhoto)),
);

final $withoutPhoto = BuildingTileStory(
  name: "Without photo",
  args: BuildingTileArgs(building: Arg.fixed(_mockBuildingWithoutPhoto)),
);

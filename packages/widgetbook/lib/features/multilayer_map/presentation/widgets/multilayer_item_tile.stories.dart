import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/multilater_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "multilayer_item_tile.stories.g.dart";

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

const _mockBuildingItemWithPlaceholderPhoto = BuildingItem(building: _mockBuildingWithPlaceholderPhoto);
const _mockBuildingItemWithoutPhoto = BuildingItem(building: _mockBuildingWithoutPhoto);

const meta = Meta<MultilayerItemTile>();

final $withPlaceholderPhoto = MultilayerItemTileStory(
  name: "With placeholder photo, active",
  args: MultilayerItemTileArgs(item: Arg.fixed(_mockBuildingItemWithPlaceholderPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhoto = MultilayerItemTileStory(
  name: "With placeholder photo, inactive",
  args: MultilayerItemTileArgs(item: Arg.fixed(_mockBuildingItemWithPlaceholderPhoto), isActive: Arg.fixed(false)),
);

final $withoutPhotoActive = MultilayerItemTileStory(
  name: "Without photo, active",
  args: MultilayerItemTileArgs(item: Arg.fixed(_mockBuildingItemWithoutPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhotoInactive = MultilayerItemTileStory(
  name: "Without photo, inactive",
  args: MultilayerItemTileArgs(item: Arg.fixed(_mockBuildingItemWithoutPhoto), isActive: Arg.fixed(false)),
);

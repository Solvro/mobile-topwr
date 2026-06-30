import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/building_tile.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../../widgetbook_placeholders.dart";

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
  cover: ImageData(url: widgetbookPlaceholderImageUrl),
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

const meta = Meta(BuildingTile.new);

final $withPlaceholderPhoto = BuildingTileStory(
  name: "With placeholder photo, active",
  args: BuildingTileArgs(building: Arg.fixed(_mockBuildingWithPlaceholderPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhoto = BuildingTileStory(
  name: "With placeholder photo, inactive",
  args: BuildingTileArgs(building: Arg.fixed(_mockBuildingWithPlaceholderPhoto), isActive: Arg.fixed(false)),
);

final $withoutPhotoActive = BuildingTileStory(
  name: "Without photo, active",
  args: BuildingTileArgs(building: Arg.fixed(_mockBuildingWithoutPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhotoInactive = BuildingTileStory(
  name: "Without photo, inactive",
  args: BuildingTileArgs(building: Arg.fixed(_mockBuildingWithoutPhoto), isActive: Arg.fixed(false)),
);

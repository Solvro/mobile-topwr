import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/multilayer_marker.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../../widgetbook_placeholders.dart";

part "multilayer_marker.stories.g.dart";

const _mockBuilding = Building(
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

const _mockBuildingItem = BuildingItem(building: _mockBuilding);

const meta = Meta(MultilayerMarker.new);

final $default = MultilayerMarkerStory(args: MultilayerMarkerArgs(item: Arg.fixed(_mockBuildingItem)));

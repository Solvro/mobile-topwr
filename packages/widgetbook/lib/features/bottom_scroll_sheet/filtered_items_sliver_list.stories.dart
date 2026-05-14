import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/bottom_scroll_sheet/multilayer_map_single_entity_list.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:widgetbook/widgetbook.dart";
import "../../widgetbook_placeholders.dart";

part "filtered_items_sliver_list.stories.g.dart";

const _mockBuilding = Building(
  rawId: 1,
  name: "Test Building",
  naturalName: "Test Building Name",
  addressLine1: "Test Address 123",
  addressLine2: "50-370 Wrocław",
  latitude: 51.1079,
  longitude: 17.0385,
  externalDigitalGuideMode: ExternalDigitalGuideMode.digitalGuideBuilding,
  externalDigitalGuideIdOrUrl: "313",
  cover: ImageData(url: widgetbookPlaceholderImageUrl),
  branch: Branch.main,
);

const _mockBuildingItem = BuildingItem(building: _mockBuilding);

const meta = Meta<FilteredItemsSliverList>();

final $default = FilteredItemsSliverListStory<BuildingItem>(
  args: FilteredItemsSliverListArgs<BuildingItem>(allItems: Arg.fixed([_mockBuildingItem])),
  setup: (context, child, args) => CustomScrollView(slivers: [child]),
);

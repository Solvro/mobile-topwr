import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/multilayer_map_single_entity_list.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockBuilding = Building(
  rawId: 1,
  name: "Test Building",
  naturalName: "Test Building Name",
  addressLine1: "Test Address 123",
  addressLine2: null,
  latitude: 51.1079,
  longitude: 17.0385,
  externalDigitalGuideMode: null,
  externalDigitalGuideIdOrUrl: null,
  cover: null,
  branch: Branch.main,
);

const _mockBuildingItem = BuildingItem(building: _mockBuilding);

@widgetbook.UseCase(name: "default", type: FilteredItemsSliverList)
Widget useCaseFilteredItemsSliverList(BuildContext context) {
  return const FilteredItemsSliverList(allItems: [_mockBuildingItem]);
}

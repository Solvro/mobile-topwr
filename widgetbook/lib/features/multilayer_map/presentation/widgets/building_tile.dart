import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/building_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockBuilding = Building(
  rawId: 1,
  name: "Main Building",
  naturalName: "Main Campus Building",
  addressLine1: "123 University Street",
  addressLine2: "Building A",
  latitude: 51.1079,
  longitude: 17.0385,
  externalDigitalGuideMode: null,
  externalDigitalGuideIdOrUrl: null,
  cover: null,
  branch: Branch.main,
);

@widgetbook.UseCase(name: "default", type: BuildingTile)
Widget useCaseBuildingTile(BuildContext context) {
  return const BuildingTile(_mockBuilding, isActive: true);
}

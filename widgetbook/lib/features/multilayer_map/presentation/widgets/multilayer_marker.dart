import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/multilayer_marker.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MultilayerMarker)
Widget useCaseMultilayerMarker(BuildContext context) {
  const mockBuilding = Building(
    rawId: 2,
    name: "Building 2",
    naturalName: "Natural Name 2",
    addressLine1: "456 Main St",
    addressLine2: "Suite 3",
    latitude: 51.1,
    longitude: 17.03,
    externalDigitalGuideMode: ExternalDigitalGuideMode.digitalGuideBuilding,
    externalDigitalGuideIdOrUrl: "guide-abc",
    cover: ImageData(url: "https://example.com/image2.png"),
    branch: Branch.main,
  );
  const item = BuildingItem(building: mockBuilding);
  return const MultilayerMarker(item: item, isActive: true);
}

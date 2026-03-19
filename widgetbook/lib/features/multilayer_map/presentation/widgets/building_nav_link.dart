import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/building_nav_link.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BuildingNavLink)
Widget useCaseBuildingNavLink(BuildContext context) {
  const mockBuilding = Building(
    rawId: 1,
    name: "Building 1",
    naturalName: "Natural Name",
    addressLine1: "123 Main St",
    addressLine2: "Apt 4",
    latitude: 50.061,
    longitude: 19.938,
    externalDigitalGuideMode: ExternalDigitalGuideMode.digitalGuideBuilding,
    externalDigitalGuideIdOrUrl: "guide-xyz",
    cover: ImageData(url: "https://example.com/image.png"),
    branch: Branch.main,
  );
  return const BuildingNavLink(isActive: true, building: mockBuilding);
}

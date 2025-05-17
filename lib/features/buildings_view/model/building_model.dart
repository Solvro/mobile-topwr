import "package:latlong2/latlong.dart";

import "../../../config/map_view_config.dart";
import "../../map_view/controllers/controllers_set.dart";
import "building_data.dart";

class BuildingModel implements GoogleNavigable {
  @override
  final String id;
  final String name;
  final String naturalName;
  final String address;
  final double latitude;
  final double longitude;
  final String coverUrl;
  final String? externalDigitalGuideMode;
  final String? externalDigitalGuideIdOrURL;

  BuildingModel.from(BuildingData building)
    : id = building.id.toString(),
      name = building.identifier,
      naturalName = building.naturalName ?? "",
      address = "${building.addressLine1}\n${building.addressLine2}".replaceFirst(",", "\n").replaceAll("\n ", "\n"),
      latitude = building.latitude,
      longitude = building.longitude,
      coverUrl = building.cover?.url ?? "",
      externalDigitalGuideMode = building.externalDigitalGuideMode,
      externalDigitalGuideIdOrURL = building.externalDigitalGuideIdOrUrl;

  @override
  LatLng get location => LatLng(latitude, longitude);

  String? get parseBuildingCode {
    final List<String> separatedBuildingName = name.split(BuildingSearchConfig.buildingCodeSeperator);

    if (separatedBuildingName.length < 2) {
      return null;
    } else {
      return separatedBuildingName[0];
    }
  }
}

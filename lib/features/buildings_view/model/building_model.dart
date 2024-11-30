import "package:latlong2/latlong.dart";

import "../../../config/map_view_config.dart";
import "../../map_view/controllers/controllers_set.dart";
import "../repository/buildings_repository.dart";

class BuildingModel extends Building implements GoogleNavigable {
  static Set<String> buildingCodesLowerCase = <String>{};

  BuildingModel.from(Building building)
      : super(
          id: building.id,
          name: building.name,
          longitude: building.longitude,
          latitude: building.latitude,
          addres: building.addres,
          cover: building.cover,
          naturalName: building.naturalName,
          disableBuildingPrefix: building.disableBuildingPrefix,
        ) {
      if(building.name[1] == BuildingSearchConfig.buildingCodeSeperator) {
        buildingCodesLowerCase.add(building.name[0].toLowerCase());
      }
  }

  @override
  LatLng get location => LatLng(latitude, longitude);

  String? get addressFormatted =>
      addres?.replaceFirst(",", "\n").replaceAll("\n ", "\n");
}

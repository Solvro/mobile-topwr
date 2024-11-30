import "package:latlong2/latlong.dart";

import "../../../config/map_view_config.dart";
import "../../../utils/contains_number.dart";
import "../../map_view/controllers/controllers_set.dart";
import "../repository/buildings_repository.dart";

class BuildingModel extends Building implements GoogleNavigable {
  static final BuildingCodesLowerCase _buildingCodesLowerCase =
      BuildingCodesLowerCase();

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
    _buildingCodesLowerCase.addBuildingCode(name);
  }

  @override
  LatLng get location => LatLng(latitude, longitude);

  String? get addressFormatted =>
      addres?.replaceFirst(",", "\n").replaceAll("\n ", "\n");

  static bool isBuildingCode(String buildingCode) {
    return _buildingCodesLowerCase.contains(buildingCode) ||
        buildingCode.containsNumber();
  }
}

class BuildingCodesLowerCase {
  final Set<String> _buildingCodesLowerCase = <String>{};

  void addBuildingCode(String buildingCode) {
    final String? code = _parseBuildingCode(buildingCode);
    if (code != null) {
      _buildingCodesLowerCase.add(code.toLowerCase());
    }
  }

  Set<String> get buildingCodesLowerCase => _buildingCodesLowerCase;

  String? _parseBuildingCode(String buildingName) {
    final List<String> separatedBuildingName =
        buildingName.split(BuildingSearchConfig.buildingCodeSeperator);

    if (separatedBuildingName.length < 2) {
      return null;
    } else {
      return separatedBuildingName[0];
    }
  }

  bool contains(String buildingCode) {
    return _buildingCodesLowerCase.contains(buildingCode);
  }
}

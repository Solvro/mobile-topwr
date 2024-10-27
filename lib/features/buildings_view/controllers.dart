import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_map/flutter_map.dart" as fl;
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../utils/contains_lower_case.dart";
import "../map_view/controllers/active_map_marker_cntrl.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/controllers/map_controller.dart";
import "../map_view/controllers/map_data_controller.dart";
import "model/building_model.dart";
import "repository/buildings_repository.dart";
import "utils.dart";

part "controllers.g.dart";

@Riverpod(dependencies: [])
class ActiveBuildingController extends _$ActiveBuildingController
    with ActiveMarkerController<BuildingModel> {
  @override
  BuildingModel? build() {
    return null;
  }
}

// this lint rule here is imo bugged; I'm pretty sure it has no reason to be triggered here
// ignore: provider_dependencies
@Riverpod(dependencies: [ActiveBuildingController])
class BuildingsViewController extends _$BuildingsViewController
    with MapDataController<BuildingModel> {
  BuildingsViewController() {
    mapControllers = mapControllersBuildings;
  }
  @override
  // ignore: unnecessary_overrides
  FutureOr<IList<BuildingModel>> build() async {
    return super.build();
  }

  @override
  bool filterMethod(BuildingModel item, String filterStr) {
    return item.name.containsBuildingCode(filterStr) ||
        item.addres.containsLowerCase(filterStr) ||
        item.naturalName.containsLowerCase(filterStr);
  }
}

// this lint rule here is imo bugged; I'm pretty sure it has no reason to be triggered here
// ignore: provider_dependencies
@Riverpod(dependencies: [ActiveBuildingController])
class BuildingsMapController extends _$BuildingsMapController
    with MapController<BuildingModel> {
  BuildingsMapController() {
    mapControllers = mapControllersBuildings;
  }

  @override
  // ignore: unnecessary_overrides
  fl.MapController build() {
    return super.build();
  }
}

final MapControllers<BuildingModel> mapControllersBuildings = (
  activeMarker: activeBuildingControllerProvider,
  sourceRepo: buildingsRepositoryProvider,
  map: buildingsMapControllerProvider,
  dataController: buildingsViewControllerProvider,
);

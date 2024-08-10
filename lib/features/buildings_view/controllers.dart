import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../map_view/controllers/active_map_marker_cntrl.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/controllers/map_controller.dart";
import "../map_view/controllers/map_data_controller.dart";
import "model/building_model.dart";
import "repository/buildings_repository.dart";
import "utils.dart";

part "controllers.g.dart";

@riverpod
class ActiveBuildingController extends _$ActiveBuildingController
    with ActiveMarkerController<BuildingModel> {
  @override
  BuildingModel? build() {
    return null;
  }
}

@riverpod
class BuildingsViewController extends _$BuildingsViewController
    with MapDataController<BuildingModel> {
  BuildingsViewController() {
    mapControllers = mapControllersBuildings;
  }
  @override
  // ignore: unnecessary_overrides
  FutureOr<IList<BuildingModel?>?> build() async {
    return super.build();
  }

  @override
  bool filterMethod(BuildingModel item, String filterStr) {
    return item.name.containsBuildingCode(filterStr) ||
        item.addres.containsBuildingCode(filterStr) ||
        item.naturalName.containsBuildingCode(filterStr);
  }
}

@riverpod
class BuildingsMapController extends _$BuildingsMapController
    with MapController<BuildingModel> {
  BuildingsMapController() {
    mapControllers = mapControllersBuildings;
  }

  @override
  GoogleMapController? build() {
    return null;
  }
}

final MapControllers<BuildingModel> mapControllersBuildings = (
  activeMarker: activeBuildingControllerProvider,
  sourceRepo: buildingsRepositoryProvider,
  map: buildingsMapControllerProvider,
  dataController: buildingsViewControllerProvider,
);

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared_repositories/buildings_repository/building_model.dart';
import '../../shared_repositories/buildings_repository/map_buildings_repo.dart';
import '../map_view/controllers/active_map_marker_cntrl.dart';
import '../map_view/controllers/controllers_set.dart';
import '../map_view/controllers/map_controller.dart';
import '../map_view/controllers/map_data_controller.dart';

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
class BuildingsListViewController extends _$BuildingsListViewController
    with MapDataController<BuildingModel> {
  BuildingsListViewController() {
    mapControllers = mapControllersBuildings;
  }
  @override
  // ignore: unnecessary_overrides
  FutureOr<Iterable<BuildingModel?>?> build() async {
    return super.build();
  }

  @override
  bool filterMethod(BuildingModel item, String filterStr) {
    return item.name.toLowerCase().contains(filterStr) ||
        (item.addres?.toLowerCase().contains(filterStr) ?? false);
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
  sourceRepo: mapBuildingsRepositoryProvider,
  map: buildingsMapControllerProvider,
  dataController: buildingsListViewControllerProvider,
);

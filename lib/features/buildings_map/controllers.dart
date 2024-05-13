import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared_repositories/buildings_repository/building_extra_params_ext.dart';
import '../../shared_repositories/buildings_repository/map_buildings_repo.dart';
import '../map_view/controllers/active_map_marker_cntrl.dart';
import '../map_view/controllers/controllers_set.dart';
import '../map_view/controllers/map_controller.dart';
import '../map_view/controllers/map_source_controller.dart';

part "controllers.g.dart";

@riverpod
class ActiveBuildingController extends _$ActiveBuildingController
    with ActiveMarkerController<Building> {
  @override
  Building? build() {
    return null;
  }
}

@riverpod
class BuildingsListViewController extends _$BuildingsListViewController
    with MapSourceController<Building> {
  BuildingsListViewController() {
    mapControllers = mapControllersBuildings;
  }
  @override
  FutureOr<Iterable<Building?>?> build() async {
    return super.build();
  }

  @override
  bool filterMethod(Building building, String filterStr) {
    return building.name.toLowerCase().contains(filterStr) ||
        building.code.toLowerCase().contains(filterStr) ||
        (building.addres?.toLowerCase().contains(filterStr) ?? false);
  }
}

@riverpod
class BuildingsMapController extends _$BuildingsMapController
    with MapController<Building> {
  BuildingsMapController() {
    mapControllers = mapControllersBuildings;
  }

  @override
  GoogleMapController? build() {
    return null;
  }

  @override
  LatLng getLocation(Building item) {
    return item.location;
  }
}

final MapControllers<Building> mapControllersBuildings = (
  activeMarker: activeBuildingControllerProvider,
  sourceRepo: mapBuildingsRepositoryProvider,
  map: buildingsMapControllerProvider,
);

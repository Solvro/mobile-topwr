import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../map_view/controllers/active_map_marker_cntrl.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/controllers/map_controller.dart";
import "../map_view/controllers/map_data_controller.dart";
import "models/parking_model.dart";
import "repositories/parkings_repo.dart";

part "controllers.g.dart";

@riverpod
class ActiveParkingController extends _$ActiveParkingController
    with ActiveMarkerController<ParkingPlace> {
  @override
  ParkingPlace? build() {
    return null;
  }
}

@riverpod
class ParkingsListViewController extends _$ParkingsListViewController
    with MapDataController<ParkingPlace> {
  ParkingsListViewController() {
    mapControllers = parkingsMapControllers;
  }
  @override
  // ignore: unnecessary_overrides
  FutureOr<Iterable<ParkingPlace?>?> build() async {
    return super.build();
  }

  @override
  bool filterMethod(ParkingPlace item, String filterStr) {
    return item.name.toLowerCase().contains(filterStr) ||
        item.symbol.toLowerCase().contains(filterStr) ||
        item.address.toLowerCase().contains(filterStr);
  }
}

@riverpod
class ParkingsMapController extends _$ParkingsMapController
    with MapController<ParkingPlace> {
  ParkingsMapController() {
    mapControllers = parkingsMapControllers;
  }

  @override
  GoogleMapController? build() {
    return null;
  }
}

final MapControllers<ParkingPlace> parkingsMapControllers = (
  activeMarker: activeParkingControllerProvider,
  sourceRepo: parkingsRepoProvider,
  map: parkingsMapControllerProvider,
  dataController: parkingsListViewControllerProvider,
);

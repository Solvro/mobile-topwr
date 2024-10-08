import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_map/flutter_map.dart" as fl_map;
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../utils/contains_lower_case.dart";
import "../map_view/controllers/active_map_marker_cntrl.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/controllers/map_controller.dart";
import "../map_view/controllers/map_data_controller.dart";
import "models/parking.dart";
import "repository/parkings_repository.dart";

part "controllers.g.dart";

@Riverpod(dependencies: [])
class ActiveParkingController extends _$ActiveParkingController
    with ActiveMarkerController<Parking> {
  @override
  Parking? build() {
    return null;
  }
}

@Riverpod(dependencies: [ActiveParkingController])
class ParkingsViewController extends _$ParkingsViewController
    with MapDataController<Parking> {
  ParkingsViewController() {
    mapControllers = parkingsMapControllers;
  }
  @override
  // ignore: unnecessary_overrides
  FutureOr<IList<Parking>> build() async {
    return super.build();
  }

  @override
  bool filterMethod(Parking item, String filterStr) {
    return item.name.containsLowerCase(filterStr) ||
        item.symbol.containsLowerCase(filterStr) ||
        item.address.containsLowerCase(filterStr);
  }
}

@Riverpod(dependencies: [ActiveParkingController])
class ParkingsMapController extends _$ParkingsMapController
    with MapController<Parking> {
  ParkingsMapController() {
    mapControllers = parkingsMapControllers;
  }

  @override
  // ignore: unnecessary_overrides
  fl_map.MapController build() {
    return super.build();
  }
}

final MapControllers<Parking> parkingsMapControllers = (
  activeMarker: activeParkingControllerProvider,
  sourceRepo: parkingsRepositoryProvider,
  map: parkingsMapControllerProvider,
  dataController: parkingsViewControllerProvider,
);

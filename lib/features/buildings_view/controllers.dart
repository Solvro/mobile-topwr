import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../utils/contains_lower_case.dart";
import "../map_view/controllers/active_map_marker_cntrl.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";
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

@Riverpod(
  dependencies: [
    bottomSheetController,
    ActiveBuildingController,
  ],
)
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

@Riverpod(
  dependencies: [
    bottomSheetController,
    ActiveBuildingController,
  ],
)
MyMapController<BuildingModel> buildingsMapController(Ref ref) {
  return MyMapController(ref, mapControllersBuildings);
}

final MapControllers<BuildingModel> mapControllersBuildings = (
  activeMarker: activeBuildingControllerProvider,
  sourceRepo: buildingsRepositoryProvider,
  map: buildingsMapControllerProvider,
  dataController: buildingsViewControllerProvider,
);

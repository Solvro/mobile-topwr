import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/contains_lower_case.dart";
import "../../map_view/controllers/active_map_marker_cntrl.dart";
import "../../map_view/controllers/bottom_sheet_controller.dart";
import "../../map_view/controllers/controllers_set.dart";
import "../../map_view/controllers/map_controller.dart";
import "../../map_view/controllers/map_data_controller.dart";
import "../business/multilayer_source_service.dart";
import "../data/model/building.dart";
import "../data/model/multilayer_item.dart";
import "../data/utils/building_codes_utils.dart";
import "../data/utils/utils.dart";

part "controllers.g.dart";

@Riverpod(dependencies: [])
class ActiveMultilaterItemController extends _$ActiveMultilaterItemController
    with ActiveMarkerController<MultilayerItem> {
  @override
  MultilayerItem? build() {
    return null;
  }
}

@Riverpod(dependencies: [bottomSheetController, ActiveMultilaterItemController])
class MultilayerMapViewController extends _$MultilayerMapViewController with MapDataController<MultilayerItem> {
  MultilayerMapViewController() {
    mapControllers = multilayerMapControllers;
  }
  @override
  // ignore: unnecessary_overrides
  FutureOr<MapDataControllerState<MultilayerItem>> build() {
    return super.build();
  }

  bool _filterBuilding(Building building, String filterStr) {
    switch (filterStr.length) {
      case 0:
        return true;
      case 1:
        if (ref.isStringABuildingCode(filterStr)) {
          return building.name.containsBuildingCode(filterStr);
        } else {
          return building.address.containsLowerCase(filterStr) || building.naturalName.containsLowerCase(filterStr);
        }
      default:
        return building.name.containsBuildingCode(filterStr) ||
            building.address.containsLowerCase(filterStr) ||
            building.naturalName.containsLowerCase(filterStr);
    }
  }

  @override
  bool filterMethod(MultilayerItem item, String filterStr) {
    if (filterStr.isEmpty) {
      return true;
    }
    return switch (item) {
      BuildingItem() => _filterBuilding(item.building, filterStr),
      LibraryItem() when item.library.building == null => item.library.title.containsLowerCase(filterStr),
      LibraryItem() when item.library.building != null =>
        item.library.title.containsLowerCase(filterStr) || _filterBuilding(item.library.building!, filterStr),
      AedItem() when item.aed.building != null => _filterBuilding(item.aed.building!, filterStr),
      BicycleShowerItem() when item.shower.building != null => _filterBuilding(item.shower.building!, filterStr),
      PinkBoxItem() when item.pinkBox.building != null => _filterBuilding(item.pinkBox.building!, filterStr),
      _ => false,
    };
  }
}

@Riverpod(dependencies: [bottomSheetController, ActiveMultilaterItemController])
MyMapController<MultilayerItem> multilayerMapController(Ref ref) {
  return MyMapController(ref, multilayerMapControllers);
}

final MapControllers<MultilayerItem> multilayerMapControllers = (
  activeMarker: activeMultilaterItemControllerProvider,
  sourceRepo: multilayerSourceServiceProvider,
  map: multilayerMapControllerProvider,
  dataController: multilayerMapViewControllerProvider,
);

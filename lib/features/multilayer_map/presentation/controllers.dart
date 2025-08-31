import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/contains_lower_case.dart";
import "../../map_view/controllers/active_map_marker_cntrl.dart";
import "../../map_view/controllers/bottom_sheet_controller.dart";
import "../../map_view/controllers/controllers_set.dart";
import "../../map_view/controllers/map_controller.dart";
import "../../map_view/controllers/map_data_controller.dart";
import "../business/multilayer_source_service.dart";
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

  @override
  bool filterMethod(MultilayerItem item, String filterStr) {
    // TODO(simon-the-shark): refactor this
    switch (filterStr.length) {
      case 0:
        return true;
      case 1:
        if (item is BuildingItem) {
          if (ref.isStringABuildingCode(filterStr)) {
            return item.building.name.containsBuildingCode(filterStr);
          } else {
            return item.building.address.containsLowerCase(filterStr) ||
                item.building.naturalName.containsLowerCase(filterStr);
          }
        }
        if (item is LibraryItem) {
          return item.library.title.containsLowerCase(filterStr);
        }
        if (item is AedItem) {
          return item.aed.building?.name.containsLowerCase(filterStr) ??
              false ||
                  item.aed.addressLine1.containsLowerCase(filterStr) ||
                  item.aed.addressLine2.containsLowerCase(filterStr);
        }
        return true;
      default:
        if (item is BuildingItem) {
          return item.building.name.containsBuildingCode(filterStr) ||
              item.building.address.containsLowerCase(filterStr) ||
              item.building.naturalName.containsLowerCase(filterStr);
        }
        if (item is LibraryItem) {
          return item.library.title.containsLowerCase(filterStr);
        }
        if (item is AedItem) {
          return item.aed.building?.name.containsLowerCase(filterStr) ??
              false ||
                  item.aed.addressLine1.containsLowerCase(filterStr) ||
                  item.aed.addressLine2.containsLowerCase(filterStr);
        }
        return true;
    }
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

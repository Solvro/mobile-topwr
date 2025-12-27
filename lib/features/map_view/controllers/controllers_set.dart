import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:latlong2/latlong.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "active_map_marker_cntrl.dart";
import "map_controller.dart";
import "map_data_controller.dart";

abstract class GoogleNavigable {
  LatLng get location;
  String get id;
}

// ignore: invalid_use_of_internal_member, caused by migration to riverpod 3.x
typedef SourceRepositoryProv<T> = $FutureModifier<IList<T>>;

typedef MapDataProv<T extends GoogleNavigable> =
    $AsyncNotifierProvider<MapDataController<T>, MapDataControllerState<T>>;

typedef ActiveMarkerProv<T extends GoogleNavigable> = $NotifierProvider<ActiveMarkerController<T>, T?>;

// ignore: invalid_use_of_internal_member, caused by migration to riverpod 3.x
typedef MapControllerProv<T extends GoogleNavigable> = $Provider<MyMapController<T>>;

typedef MapControllers<T extends GoogleNavigable> = ({
  ActiveMarkerProv<T> activeMarker,
  SourceRepositoryProv<T> sourceRepo,
  MapControllerProv<T> map,
  MapDataProv<T> dataController,
});

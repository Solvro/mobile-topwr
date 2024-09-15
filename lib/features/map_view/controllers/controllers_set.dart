import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "active_map_marker_cntrl.dart";
import "map_controller.dart";
import "map_data_controller.dart";

abstract class GoogleNavigable {
  LatLng get location;
  String get id;
}

typedef SourceRepositoryProv<T> = AutoDisposeFutureProvider<IList<T>>;

typedef MapDataProv<T extends GoogleNavigable>
    = AutoDisposeAsyncNotifierProvider<MapDataController<T>, IList<T>>;

typedef ActiveMarkerProv<T extends GoogleNavigable>
    = AutoDisposeNotifierProvider<ActiveMarkerController<T>, T?>;

typedef MapControllerProv<T extends GoogleNavigable>
    = AutoDisposeNotifierProvider<MapController<T>, GoogleMapController?>;

typedef MapControllers<T extends GoogleNavigable> = ({
  ActiveMarkerProv<T> activeMarker,
  SourceRepositoryProv<T> sourceRepo,
  MapControllerProv<T> map,
  MapDataProv<T> dataController,
});

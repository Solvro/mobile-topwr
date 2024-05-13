import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'active_map_marker_cntrl.dart';
import 'map_controller.dart';

typedef SourceRepositoryProv<T> = AutoDisposeStreamProvider<Iterable<T?>?>;

typedef ActiveMarkerProv<T>
    = AutoDisposeNotifierProvider<ActiveMarkerController<T>, T?>;

typedef MapControllerProv<T>
    = AutoDisposeNotifierProvider<MapController<T>, GoogleMapController?>;

typedef MapControllers<T> = ({
  ActiveMarkerProv<T> activeMarker,
  SourceRepositoryProv<T> sourceRepo,
  MapControllerProv<T> map,
});

final Provider<MapControllers> mapControllersProvider =
    Provider<MapControllers>(
  (ref) => throw UnimplementedError(),
);

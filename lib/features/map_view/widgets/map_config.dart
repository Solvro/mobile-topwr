import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/controllers_set.dart';

typedef MarkerBuilder<T> = Marker Function(T item, WidgetRef ref);

typedef MapTileBuilder<T> = Widget Function(T item);

class MapConfig<T> extends InheritedWidget {
  const MapConfig({
    super.key,
    required this.controllers,
    required this.markerBuilder,
    required this.mapTileBuilder,
    required super.child,
  });

  final MapControllers<T> controllers;
  final MarkerBuilder<T> markerBuilder;
  final MapTileBuilder<T> mapTileBuilder;

  static MapConfig<T>? maybeOf<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MapConfig<T>>();
  }

  static MapConfig<T> of<T>(BuildContext context) {
    final result = maybeOf<T>(context);
    assert(result != null, 'No MapConfig found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant MapConfig<dynamic> oldWidget) {
    return controllers != oldWidget.controllers;
  }
}

extension MapConfigExt<T> on BuildContext {
  MapConfig<T> get config {
    return MapConfig.of<T>(this);
  }

  MapControllerProv<T> get mapController {
    return config.controllers.map;
  }

  SourceRepositoryProv<T> get mapSourceRepository {
    return config.controllers.sourceRepo;
  }

  ActiveMarkerProv<T> get activeMarkerController {
    return config.controllers.activeMarker;
  }

  MapDataProv<T> get mapDataController {
    return config.controllers.dataController;
  }

  MarkerBuilder<T> get markerBuilder {
    return config.markerBuilder;
  }

  MapTileBuilder<T> get mapTileBuilder {
    return config.mapTileBuilder;
  }
}

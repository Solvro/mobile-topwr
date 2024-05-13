import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/controllers_set.dart';

typedef MarkerBuilder<T> = Marker Function(T item, WidgetRef ref);

class MapConfig<T> extends InheritedWidget {
  const MapConfig({
    super.key,
    required this.controllers,
    required this.markerBuilder,
    required super.child,
  });

  final MapControllers<T> controllers;
  final MarkerBuilder<T> markerBuilder;

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

  SourceRepositoryProv<T> get mapSourceController {
    return config.controllers.sourceRepo;
  }

  ActiveMarkerProv<T> get activeMarkerController {
    return config.controllers.activeMarker;
  }

  MarkerBuilder<T> get markerBuilder {
    return config.markerBuilder;
  }
}

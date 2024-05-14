import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/controllers_set.dart';

typedef MarkerBuilder<T> = Marker Function(
    T item, WidgetRef ref, bool isActive);

typedef MapTileBuilder<T> = Widget Function(T item, bool isActive);

typedef MapViewTexts = ({
  String emptyList,
  String title,
});

class MapConfig<T> extends InheritedWidget {
  const MapConfig({
    super.key,
    required this.controllers,
    required this.markerBuilder,
    required this.mapTileBuilder,
    required this.mapViewTexts,
    required super.child,
  });

  final MapControllers<T> controllers;
  final MarkerBuilder<T> markerBuilder;
  final MapTileBuilder<T> mapTileBuilder;
  final MapViewTexts mapViewTexts;

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

extension MapConfigExt on BuildContext {
  MapConfig<T> config<T>() {
    return MapConfig.of<T>(this);
  }

  MapControllerProv<T> mapController<T>() {
    return config<T>().controllers.map;
  }

  SourceRepositoryProv<T> mapSourceRepository<T>() {
    return config<T>().controllers.sourceRepo;
  }

  ActiveMarkerProv<T> activeMarkerController<T>() {
    return config<T>().controllers.activeMarker;
  }

  MapDataProv<T> mapDataController<T>() {
    return config<T>().controllers.dataController;
  }

  MarkerBuilder<T> markerBuilder<T>() {
    return config<T>().markerBuilder;
  }

  MapTileBuilder<T> mapTileBuilder<T>() {
    return config<T>().mapTileBuilder;
  }

  MapViewTexts mapViewTexts<T>() {
    return config<T>().mapViewTexts;
  }
}

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

import "../../../config/map_view_config.dart";
import "../controllers/controllers_set.dart";

typedef MarkerBuilder<T> = Marker Function(
  T item,
  WidgetRef ref, {
  required bool isActive,
});

typedef MapTileBuilder<T> = Widget Function(T item, {required bool isActive});

typedef MapViewTexts = ({
  String emptyList,
  String title,
});

class MapConfig<T extends GoogleNavigable> extends InheritedWidget {
  const MapConfig({
    super.key,
    required this.controllers,
    required this.markerBuilder,
    required this.mapTileBuilder,
    required this.mapViewTexts,
    required super.child,
    required this.mapSheetSize,
  });

  final MapControllers<T> controllers;
  final MarkerBuilder<T> markerBuilder;
  final MapTileBuilder<T> mapTileBuilder;
  final MapViewTexts mapViewTexts;
  final MapSheetSize mapSheetSize;

  static MapConfig<T>? maybeOf<T extends GoogleNavigable>(
    BuildContext context,
  ) {
    return context.dependOnInheritedWidgetOfExactType<MapConfig<T>>();
  }

  static MapConfig<T> of<T extends GoogleNavigable>(BuildContext context) {
    final result = maybeOf<T>(context);
    assert(result != null, "No MapConfig found in context");
    return result!;
  }

  @override
  bool updateShouldNotify(covariant MapConfig<dynamic> oldWidget) {
    return controllers != oldWidget.controllers;
  }
}

extension MapConfigExt on BuildContext {
  MapConfig<T> config<T extends GoogleNavigable>() {
    return MapConfig.of<T>(this);
  }

  MapControllerProv<T> mapController<T extends GoogleNavigable>() {
    return config<T>().controllers.map;
  }

  SourceRepositoryProv<T> mapSourceRepository<T extends GoogleNavigable>() {
    return config<T>().controllers.sourceRepo;
  }

  ActiveMarkerProv<T> activeMarkerController<T extends GoogleNavigable>() {
    return config<T>().controllers.activeMarker;
  }

  MapDataProv<T> mapDataController<T extends GoogleNavigable>() {
    return config<T>().controllers.dataController;
  }

  MarkerBuilder<T> markerBuilder<T extends GoogleNavigable>() {
    return config<T>().markerBuilder;
  }

  MapTileBuilder<T> mapTileBuilder<T extends GoogleNavigable>() {
    return config<T>().mapTileBuilder;
  }

  MapViewTexts mapViewTexts<T extends GoogleNavigable>() {
    return config<T>().mapViewTexts;
  }

  MapSheetSize mapSheetSize<T extends GoogleNavigable>() {
    return config<T>().mapSheetSize;
  }
}

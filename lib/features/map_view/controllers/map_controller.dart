import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_animations/flutter_map_animations.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/map_view_config.dart";
import "../utils/lat_lng_validity.dart";
import "bottom_sheet_controller.dart";
import "controllers_set.dart";

class MyMapController<T extends GoogleNavigable> {
  static const _defaultFitPadding = EdgeInsets.all(24);

  final Ref ref;
  final MapControllers<T> mapControllers;
  MyMapController(this.ref, this.mapControllers);

  // nasty, but no other option I think
  final _controllerCompleter = Completer<AnimatedMapController>();
  Future<AnimatedMapController> get _controller => _controllerCompleter.future;
  void completeController(AnimatedMapController controller) {
    if (!_controllerCompleter.isCompleted) {
      _controllerCompleter.complete(controller);
    }
  }

  Future<void> zoomOnMarker(T item, {double? zoom}) async {
    if (!item.location.isValidForMap) return;
    final controller = await _controller;
    await controller.animateTo(
      dest: item.location,
      zoom: zoom ?? MapWidgetConfig.defaultMarkerZoom,
      offset: Offset(0, -ref.read(bottomSheetControllerProvider).pixelsSafe / 2),
      rotation: 0,
    );
  }

  Future<void> zoomOnItems(
    Iterable<T> items, {
    EdgeInsets padding = _defaultFitPadding,
    double? maxZoom,
    double? singleItemZoom,
  }) async {
    final validItems = items.where((item) => item.location.isValidForMap).toList();
    if (validItems.isEmpty) return;
    if (validItems.length == 1) {
      return zoomOnMarker(validItems.first, zoom: singleItemZoom);
    }

    final controller = await _controller;
    await controller.animatedFitCamera(
      cameraFit: CameraFit.coordinates(
        coordinates: validItems.map((item) => item.location).toList(),
        padding: EdgeInsets.fromLTRB(
          padding.left,
          padding.top,
          padding.right,
          padding.bottom + ref.read(bottomSheetControllerProvider).pixelsSafe,
        ),
        maxZoom: maxZoom,
      ),
      rotation: 0,
    );
  }

  Future<void> onMarkerTap(T item) async {
    final currentlyActive = ref.read(mapControllers.activeMarker);
    final isDeactivating = currentlyActive == item;
    final sheet = ref.read(bottomSheetControllerProvider);

    ref.read(mapControllers.activeMarker.notifier).toggleItem(item);

    // Activate: snap sheet to recommended size. Deactivate: expansion + list
    // offset are restored by usePreservedSheetPosition — don't resetSafe.
    if (!isDeactivating && ref.read(mapControllers.activeMarker) == item) {
      sheet.resetSafe();
      await zoomOnMarker(item);
    }
  }

  void onMapBackgroundTap(_, _) {
    final currentlyActive = ref.read(mapControllers.activeMarker);
    ref.read(mapControllers.activeMarker.notifier).unselect();
    // Only reset when there was nothing to restore (already inactive / expanded sheet).
    if (currentlyActive == null) {
      ref.read(bottomSheetControllerProvider).resetSafe();
    }
  }
}

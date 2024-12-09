import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_map_animations/flutter_map_animations.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/map_view_config.dart";
import "bottom_sheet_controller.dart";
import "controllers_set.dart";

class MyMapController<T extends GoogleNavigable> {
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

  Future<void> zoomOnMarker(T item) async {
    final controller = await _controller;
    await controller.animateTo(
      dest: item.location,
      zoom: MapWidgetConfig.defaultMarkerZoom,
      offset: Offset(
        0,
        -ref.read(bottomSheetControllerProvider).pixelsSafe / 2,
      ),
      rotation: 0,
    );
  }

  Future<void> onMarkerTap(T item) async {
    ref.read(mapControllers.activeMarker.notifier).toggleItem(item);
    ref.read(bottomSheetControllerProvider).resetSafe();
    if (ref.read(mapControllers.activeMarker) == item) {
      await zoomOnMarker(item);
    }
  }

  void onMapBackgroundTap(_, __) {
    ref.read(mapControllers.activeMarker.notifier).unselect();
    ref.read(bottomSheetControllerProvider).resetSafe();
  }
}

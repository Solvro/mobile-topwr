import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart" as fl_map;
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/map_view_config.dart";
import "bottom_sheet_controller.dart";
import "controllers_set.dart";

mixin MapController<T extends GoogleNavigable>
    on AutoDisposeNotifier<fl_map.MapController> {
  late final MapControllers<T> mapControllers;

  @override
  fl_map.MapController build() {
    return fl_map.MapController();
  }

  void zoomOnMarker(T item) {
    state.move(
      item.location,
      MapWidgetConfig.defaultMarkerZoom,
      offset: Offset(
        0,
        -ref.read(bottomSheetControllerProvider).pixelsSafe / 2,
      ),
    );
  }

  void onMarkerTap(T item) {
    ref.read(mapControllers.activeMarker.notifier).toggleItem(item);
    ref.read(bottomSheetControllerProvider).resetSafe();
    if (ref.read(mapControllers.activeMarker) == item) {
      zoomOnMarker(item);
    }
  }

  void onMapBackgroundTap(_, __) {
    ref.read(mapControllers.activeMarker.notifier).unselect();
    ref.read(bottomSheetControllerProvider).resetSafe();
  }
}

import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../map_view/controllers/active_map_marker_cntrl.dart";
import "../../map_view/controllers/controllers_set.dart";

/// Use this hook to select an item when the widget is first built.
void useInitialActiveId<T extends GoogleNavigable>(
  String? initialActiveId,
  ActiveMarkerController<T> activeMarkerController,
  void Function(T item) zoomOnMarker,
  IList<T> items,
) {
  if (initialActiveId == null) return;
  useEffect(() {
    final activeItem = items.firstWhereOrNull((item) => item.id == initialActiveId);
    if (activeItem != null) {
      Future.microtask(() => activeMarkerController.selectItem(activeItem));
      Future.delayed(Durations.short1, () => zoomOnMarker(activeItem));
    }
    return null;
  }, [initialActiveId]);
}

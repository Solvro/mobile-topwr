import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/where_non_null_iterable.dart";
import "../controllers/controllers_set.dart";
import "map_config.dart";

class MarkersConsumerLayer<T extends GoogleNavigable> extends ConsumerWidget {
  const MarkersConsumerLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(context.mapSourceRepository<T>()).value.whereNonNull.toList();
    final activeItem = ref.watch(context.activeMarkerController<T>());
    final markerZIndex = context.markerZIndex<T>();
    if (markerZIndex != null) {
      asyncItems.sort((a, b) => markerZIndex(a).compareTo(markerZIndex(b)));
    }
    return MarkerLayer(
      markers: asyncItems.map((item) => context.markerBuilder<T>()(item, ref, isActive: activeItem == item)).toList(),
      rotate: true,
    );
  }
}

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/where_non_null_iterable.dart";
import "../controllers/controllers_set.dart";
import "../utils/lat_lng_validity.dart";
import "map_config.dart";

class MarkersConsumerLayer<T extends GoogleNavigable> extends ConsumerWidget {
  const MarkersConsumerLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncItems = ref
        .watch(context.mapSourceRepository<T>())
        .value
        .whereNonNull
        .where((item) => item.location.isValidForMap)
        .toIList();
    final activeItem = ref.watch(context.activeMarkerController<T>());
    final markerZIndex = context.markerZIndex<T>();
    if (markerZIndex != null) {
      asyncItems = asyncItems.sort((a, b) {
        final activeComparison = (a == activeItem ? 1 : 0).compareTo(b == activeItem ? 1 : 0);
        if (activeComparison != 0) return activeComparison;
        return markerZIndex(a).compareTo(markerZIndex(b));
      });
    }
    return MarkerLayer(
      markers: asyncItems.map((item) => context.markerBuilder<T>()(item, ref, isActive: activeItem == item)).toList(),
      rotate: true,
    );
  }
}

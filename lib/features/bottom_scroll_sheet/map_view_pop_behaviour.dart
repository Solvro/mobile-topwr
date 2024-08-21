import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../map_view/controllers/bottom_sheet_controller.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";

class MapViewPopBehaviour<T extends GoogleNavigable> extends ConsumerWidget {
  const MapViewPopBehaviour({
    required this.child,
    required this.screenHeight,
    super.key,
  });
  final double screenHeight;
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAlmostFullyExtended =
        ref.watch(bottomSheetPixelsProvider) / screenHeight > 0.98;

    final isAnyActive = ref.watch(context.activeMarkerController<T>()) != null;

    return PopScope(
      canPop: !isAnyActive && !isAlmostFullyExtended,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          ref
              .read(context.mapController<T>().notifier)
              .onMapBackgroundTap(null);
          ref.read(bottomSheetControllerProvider).resetSafe();
        }
      },
      child: child,
    );
  }
}

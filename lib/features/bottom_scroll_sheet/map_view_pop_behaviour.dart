import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../services/pop_scope/pop_priority.dart";
import "../../services/pop_scope/use_block_pop.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";

class MapViewPopBehaviour<T extends GoogleNavigable> extends HookConsumerWidget {
  const MapViewPopBehaviour({required this.child, required this.screenHeight, super.key});
  final double screenHeight;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAlmostFullyExtended = ref.watch(bottomSheetPixelsProvider) / screenHeight > 0.98;
    final isAnyActive = ref.watch(context.activeMarkerController<T>()) != null;
    final needsCustomPopAction = isAnyActive || isAlmostFullyExtended;

    useBlockPop(
      ref: ref,
      blockDefaultPop: needsCustomPopAction,
      onCustomPopAction: () {
        ref.read(context.mapController<T>()).onMapBackgroundTap(null, null);
        ref.read(bottomSheetControllerProvider).resetSafe();
      },
      order: PopScopeOrder.first,
    );
    return child;
  }
}

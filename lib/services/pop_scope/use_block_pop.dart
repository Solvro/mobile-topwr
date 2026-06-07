import "package:flutter/widgets.dart" show VoidCallback, WidgetsBinding;
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../utils/unwaited_microtask.dart";
import "pop_priority.dart";
import "pop_scope_coordinator.dart";

void useBlockPop({
  required VoidCallback onCustomPopAction,
  required bool blockDefaultPop,
  required WidgetRef ref,
  PopScopeOrder order = PopScopeOrder.last,
}) {
  final coordinator = ref.read(popScopeCoordinatorProvider.notifier);
  useEffect(() {
    var callbackId = "";
    var disposed = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (disposed) return;
      callbackId = coordinator.registerCallback(
        onCustomPopAction: onCustomPopAction,
        blockDefaultPop: blockDefaultPop,
        order: order,
      );
    });
    return () {
      disposed = true;
      if (callbackId.isNotEmpty) {
        unwaitedMicrotask(() async {
          coordinator.unregisterCallback(callbackId);
        });
      }
    };
  }, [onCustomPopAction, blockDefaultPop, coordinator]);
}

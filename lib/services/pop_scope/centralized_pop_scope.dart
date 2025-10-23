import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "pop_scope_coordinator.dart";

/// A centralized navigation widget that provides a single PopScope
/// for the entire app with priority-based callback system
/// All navigation logic is handled through registered callbacks
class CentralizedPopScope extends ConsumerWidget {
  const CentralizedPopScope({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockDefaultPop = ref.watch(
      popScopeCoordinatorProvider.select((state) => state.any((callback) => callback.blockDefaultPop)),
    );
    final coordinator = ref.watch(popScopeCoordinatorProvider.notifier);
    return PopScope(
      canPop: !blockDefaultPop,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          coordinator.onCustomPopAction();
        }
      },
      child: child,
    );
  }
}

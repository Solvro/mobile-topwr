import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart" show VoidCallback;
import "package:riverpod_annotation/riverpod_annotation.dart";

import "pop_priority.dart";

part "pop_scope_coordinator.g.dart";

typedef NavigationCallbackRegistration = ({
  String id,
  VoidCallback onCustomPopAction,
  bool blockDefaultPop,
  PopScopeOrder order,
});

/// A centralized navigation pop scope coordinator that manages a single PopScope
/// with priority-based callback registration (only calls one callback).
/// Solves this issue: https://github.com/flutter/flutter/issues/144074 (but in a very verbose way)
@Riverpod(keepAlive: true)
class PopScopeCoordinator extends _$PopScopeCoordinator {
  @override
  IList<NavigationCallbackRegistration> build() {
    return const IList.empty();
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() + (state.length + 1).toString();
  }

  String registerCallback({
    required VoidCallback onCustomPopAction,
    required bool blockDefaultPop,
    required PopScopeOrder order,
  }) {
    if (!ref.mounted) return "";

    final id = _generateId();
    final registration = (id: id, onCustomPopAction: onCustomPopAction, blockDefaultPop: blockDefaultPop, order: order);
    state = state.add(registration);
    return id;
  }

  void unregisterCallback(String id) {
    if (!ref.mounted) return;

    state = state.where((cb) => cb.id != id).toIList();
  }

  void onCustomPopAction() {
    // Execute first callback that returns that it blocks navigation

    if (!ref.mounted) return;

    for (final registration in state.where((r) => r.blockDefaultPop).sortedBy((r) => r.order.value)) {
      return registration.onCustomPopAction();
    }
  }
}

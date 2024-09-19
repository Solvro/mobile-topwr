import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "navigation_controller.dart";

part "navigation_observer.g.dart";

/// so this just listens to navigation events and notifies the [NavigationController] to refresh its state
/// we do not even use all of these callbacks, but they're for future-proofing
class _NavigationObserver extends AutoRouterObserver {
  final Ref ref;

  _NavigationObserver(this.ref);

  void _notifyController() {
    ref.read(navigationControllerProvider.notifier).refreshState();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _notifyController();
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _notifyController();
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _notifyController();
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _notifyController();
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

@riverpod
AutoRouterObserver navigationObserver(NavigationObserverRef ref) {
  return _NavigationObserver(ref);
}

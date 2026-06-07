import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/nav_bar_config.dart";

part "navigation_stack.g.dart";

@Riverpod(keepAlive: true)
class NavigationStack extends _$NavigationStack {
  @override
  IList<Route<dynamic>> build() {
    return const IList.empty();
  }

  void setStack(IList<Route<dynamic>> value) {
    if (!ref.mounted) return;
    state = value;
  }
}

@Riverpod(keepAlive: true)
Route<dynamic>? currentRoute(Ref ref) {
  final stack = ref.watch(navigationStackProvider);
  if (stack.isEmpty) {
    return null;
  }
  return stack.last; // top most route
}

@riverpod
Route<dynamic>? previousRoute(Ref ref) {
  final stack = ref.watch(navigationStackProvider);
  if (stack.length <= 1) {
    return null;
  }
  return stack.removeLast().last; // second top most route
}

@Riverpod(keepAlive: true)
class RootRouteActiveTabs extends _$RootRouteActiveTabs {
  @override
  IMap<Route<dynamic>, NavBarEnum> build() {
    return <Route<dynamic>, NavBarEnum>{}.lock;
  }

  void setActiveTab(Route<dynamic> route, NavBarEnum tab) {
    if (!ref.mounted) return;
    if (state[route] == tab) return;
    state = state.add(route, tab);
  }

  void remove(Route<dynamic> route) {
    if (!ref.mounted) return;
    if (!state.containsKey(route)) return;
    state = state.remove(route);
  }
}

/*
  This class is used to observe the navigation stack
  Acts as a bridge between navigator and riverpod state notifier
*/
class NavigationObserver extends NavigatorObserver {
  final WidgetRef ref;
  final BuildContext context;

  NavigationObserver(this.ref, this.context);

  var _stack = const IList<Route<dynamic>>.empty();
  var _removedRoutes = const ISet<Route<dynamic>>.empty();
  var _flushScheduled = false;

  /*
  This 2 methods sync observer with the riverpod state
  */
  void setStack(IList<Route<dynamic>> value) {
    _stack = value;
    _scheduleProviderFlush();
  }

  IList<Route<dynamic>> get stack => _stack;

  void _scheduleProviderFlush() {
    if (_flushScheduled) return;
    _flushScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _flushScheduled = false;
      if (!context.mounted) return;
      _removedRoutes.forEach(ref.read(rootRouteActiveTabsProvider.notifier).remove);
      _removedRoutes = const ISet<Route<dynamic>>.empty();
      ref.read(navigationStackProvider.notifier).setStack(_stack);
    });
  }

  void _removeRoute(Route<dynamic> route) {
    _removedRoutes = _removedRoutes.add(route);
    setStack(stack.where((stackRoute) => !identical(stackRoute, route)).toIList());
  }

  /*
  This 4 methods sync observer with the actual navigation stack
  */
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _removeRoute(route);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    setStack(stack.add(route));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null) {
      _removedRoutes = _removedRoutes.add(oldRoute);
    }
    if (newRoute == null) {
      if (oldRoute != null) _removeRoute(oldRoute);
      return;
    }
    if (oldRoute == null) {
      setStack(stack.add(newRoute));
      return;
    }

    final index = stack.indexWhere((stackRoute) => identical(stackRoute, oldRoute));
    if (index == -1) {
      setStack(stack.add(newRoute));
      return;
    }
    setStack(stack.replace(index, newRoute));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _removeRoute(route);
  }
}

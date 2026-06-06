import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/nav_bar_config.dart";
import "../../utils/unwaited_microtask.dart";

part "navigation_stack.g.dart";

@Riverpod(keepAlive: true)
class NavigationStack extends _$NavigationStack {
  @override
  IList<Route<dynamic>> build() {
    return const IList.empty();
  }

  void setStack(IList<Route<dynamic>> value) {
    state = value;
  }
}

@riverpod
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
  Map<Route<dynamic>, NavBarEnum> build() {
    return const {};
  }

  void setActiveTab(Route<dynamic> route, NavBarEnum tab) {
    if (state[route] == tab) return;
    state = {...state, route: tab};
  }

  void remove(Route<dynamic> route) {
    if (!state.containsKey(route)) return;
    state = {...state}..remove(route);
  }
}

/*
  This class is used to observe the navigation stack
  Acts as a bridge between navigator and riverpod state notifier
*/
class NavigationObserver extends NavigatorObserver {
  final WidgetRef ref;

  NavigationObserver(this.ref);

  var _stack = const IList<Route<dynamic>>.empty();
  final _removedRoutes = <Route<dynamic>>{};
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
    unwaitedMicrotask(() async {
      _flushScheduled = false;
      _removedRoutes.forEach(ref.read(rootRouteActiveTabsProvider.notifier).remove);
      _removedRoutes.clear();
      ref.read(navigationStackProvider.notifier).setStack(_stack);
    });
  }

  void _removeRoute(Route<dynamic> route) {
    _removedRoutes.add(route);
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
      _removedRoutes.add(oldRoute);
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

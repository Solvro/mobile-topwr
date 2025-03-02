import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/nav_bar_config.dart";
import "app_router.dart";

part "navigation_controller.g.dart";

typedef TRoute = PageRouteInfo<dynamic>;

typedef NavigationState = ({bool isStackPoppable, NavBarEnum activeTab, IList<TRoute> fullNavigationStack});

@riverpod
GlobalKey<AutoRouterState> navigatorKey(Ref ref) {
  return GlobalKey<AutoRouterState>();
}

@riverpod
class NavigationController extends _$NavigationController {
  GlobalKey<AutoRouterState> get _navigatorKey => ref.watch(navigatorKeyProvider);

  StackRouter? get _router => _navigatorKey.currentState?.controller;

  Iterable<TRoute> get _stack => _router?.stackData.map((e) => e.route.toPageRouteInfo()) ?? [];

  Future<void> keepTrackOfTabBarState(Future<void>? popFutureResults) async {
    await Future.delayed(
      Duration.zero,
      refreshState, // refresh the state after the push
    );
    // await the route's pop
    if (popFutureResults != null) await popFutureResults;
    refreshState(); // refresh the state after the pop
  }

  Future<void> push(TRoute route) async {
    final popFutureResults = _router?.push(route); // push the route
    await keepTrackOfTabBarState(popFutureResults);
  }

  Future<void> pushNamed(String uri) async {
    final lastRoute = _fullStack.lastOrNull;
    final isCurrentlyWithinTabView = ref
        .read(appRouterProvider)
        .routesWithinTabBar
        .any((route) => route.name == lastRoute?.routeName);
    final isDestinationWithinTabView = ref
        .read(appRouterProvider)
        .routesWithinTabBar
        .any((route) => route.path.split("/").first == uri.split("/").first);
    final properlyWorkingURI = !isDestinationWithinTabView ? "/$uri" : uri;
    final shouldPopBefore = !isCurrentlyWithinTabView && isDestinationWithinTabView;
    if (shouldPopBefore) {
      _popGlobalRouter();
    }
    final popFutureResults = _router?.pushPath(properlyWorkingURI); // push the route
    await keepTrackOfTabBarState(popFutureResults);
  }

  /// this is called only when you actually **click** in the nav tab bar
  /// so we don't call this on other navigation actions (like `Lista >` buttons)
  Future<void> onTabBarChange(NavBarEnum item) async {
    final route = NavBarConfig.tabViews[item]!;
    if (_stack.last.routeName != route.routeName) {
      _popUntilTabBarView();
      await push(route);
    }
  }

  /// pops details views above tab views
  void _popUntilTabBarView() {
    _router?.popUntil(
      (element) =>
          element.settings is! AutoRoutePage ||
          (element.settings as AutoRoutePage).routeData.topMatch.toPageRouteInfo().isTabView,
    );
  }

  void _popGlobalRouter() {
    _router?.root.popUntil(
      (element) =>
          element.settings is! AutoRoutePage ||
          (element.settings as AutoRoutePage).routeData.topMatch.toPageRouteInfo().isRouteGlobalRoute,
    );
  }

  void refreshState() {
    state = build();
  }

  // so the problem is that we use both nested and global navigator and they have separate navigation stacks
  List<TRoute> get _fullStack => [
    ..._stack, // nested navigator stack
    ..._router?.root.stackData
            .map(
              (e) => e.route.toPageRouteInfo(), // global navigator stack
            )
            .where((element) => !element.isRouteGlobalRoute) ??
        [],
  ]; // we spread both stacks to get proper combined stack

  @override
  NavigationState build() {
    return (
      isStackPoppable: _stack.length > 1,
      activeTab: _stack.lastWhereOrNull((element) => element.isTabView)?.tabBarEnum ?? NavBarEnum.home,
      fullNavigationStack: _fullStack.toIList(),
    );
  }
}

@riverpod
TRoute? previousRouteOnStack(Ref ref, String currentRouteName) {
  final fullStack = ref.watch(navigationControllerProvider).fullNavigationStack;
  final currentRouteIndex = fullStack.lastIndexWhere((element) => element.routeName == currentRouteName);
  if (currentRouteIndex > 0) {
    return fullStack[currentRouteIndex - 1];
  }
  return null;
}

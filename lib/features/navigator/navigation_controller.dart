import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/nav_bar_config.dart";
import "app_router.dart";
import "navigation_stack.dart";

part "navigation_controller.g.dart";

typedef TRoute = PageRouteInfo<dynamic>;

@riverpod
class NavigationController extends _$NavigationController {
  StackRouter? get _router => state.currentState?.controller;

  Future<void> push(TRoute route) async {
    await _router?.push(route);
  }

  // this manually handles deeplinks when they are launched within/inside the app
  Future<void> pushNamed(String uri) async {
    final lastRoute = ref.read(currentRouteProvider);
    final routesWithinTabBar = ref.read(appRouterProvider).routesWithinTabBar;
    final isCurrentlyWithinTabView = routesWithinTabBar.any((route) => route.name == lastRoute?.settings.name);
    final isDestinationWithinTabView = routesWithinTabBar.any(
      (route) => route.path == uri || uri.startsWith("buildings") || uri.startsWith("parkings"),
    );
    final properlyWorkingURI = !isDestinationWithinTabView ? "/$uri" : uri;
    final shouldPopBeforeNavigating = !isCurrentlyWithinTabView && isDestinationWithinTabView;
    if (shouldPopBeforeNavigating) {
      _router?.root.popUntil((element) => element.settings.name == RootRoute.name); // pop to root (tab bar view)
    }
    await _router?.pushPath(properlyWorkingURI);
  }

  /// this is called only when you actually **click** in the nav tab bar
  /// so we don't call this on other navigation actions (like `Lista >` buttons)
  Future<void> onTabBarChange(NavBarEnum item) async {
    final route = NavBarConfig.tabViews[item]!;
    if (_router?.stackData.last.route.name != route.routeName) {
      await push(route);
    }
  }

  @override
  GlobalKey<AutoRouterState> build() {
    return GlobalKey<AutoRouterState>();
  }
}

import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/nav_bar_config.dart";
import "app_router.dart";
import "navigation_stack.dart";

part "navigation_controller.g.dart";

typedef TRoute = PageRouteInfo<dynamic>;

@Riverpod(keepAlive: true)
class NavigationController extends _$NavigationController {
  StackRouter? get _router => ref.watch(appRouterProvider);

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
    final shouldPushNewRootView = !isCurrentlyWithinTabView && isDestinationWithinTabView;
    if (shouldPushNewRootView) {
      final tabRoute = ref.read(appRouterProvider).pathToRoute(uri);
      await _router?.push(
        RootRoute(
          initialTabToGetBackTo: NavBarConfig.reversedTabViews[tabRoute.routeName]!,
          children: [tabRoute],
          isFirstRootBottomView: false,
        ),
      );
      return;
    }
    final properlyWorkingURI = !isDestinationWithinTabView ? "/$uri" : uri;
    await _router?.pushPath(properlyWorkingURI);
  }

  @override
  GlobalKey<AutoRouterState> build() {
    return GlobalKey<AutoRouterState>();
  }
}

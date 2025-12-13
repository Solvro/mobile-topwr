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

  // this manually handles deeplinks
  Future<void> pushNamed(String uri) async {
    final isCurrentlyWithinTabView = _isCurrentlyWithinTabView();

    final uriPath = uri.split("?").first;
    final basePath = uriPath.split("/").where((s) => s.isNotEmpty).firstOrNull ?? "";
    final isDestinationWithinTabView = ref.read(appRouterProvider).pathToRoute(uriPath) != null;

    final shouldPushNewRootView = !isCurrentlyWithinTabView && isDestinationWithinTabView;
    if (shouldPushNewRootView) {
      final tabRoute = ref.read(appRouterProvider).pathToRoute(uri);

      if (tabRoute == null) {
        final properlyWorkingURI = !isDestinationWithinTabView ? "/$uri" : uri;
        await _router?.pushPath(properlyWorkingURI);
        return;
      }

      final navBarEnum =
          NavBarConfig.reversedTabViews[tabRoute.routeName] ??
          switch (basePath) {
            "" => NavBarEnum.home,
            "buildings" ||
            "libraries" ||
            "aeds" ||
            "bicycle-showers" ||
            "pink-boxes" ||
            "multilayer-map" => NavBarEnum.buildings,
            "parkings" => NavBarEnum.parkings,
            "guide" => NavBarEnum.guide,
            "navigation" => NavBarEnum.navigation,
            _ => null,
          };

      if (navBarEnum == null) {
        final properlyWorkingURI = !isDestinationWithinTabView ? "/$uri" : uri;
        await _router?.pushPath(properlyWorkingURI);
        return;
      }

      await _router?.push(
        RootRoute(initialTabToGetBackTo: navBarEnum, children: [tabRoute], isFirstRootBottomView: false),
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

  bool _isCurrentlyWithinTabView() {
    final lastRoute = ref.read(currentRouteProvider);
    final routeSettings = lastRoute?.settings;
    if (routeSettings is AutoRoutePage) {
      return routeSettings.routeData.name == RootRoute.name;
    }
    return false;
  }
}

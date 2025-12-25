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

  /// Manually handles deeplinks by determining if the destination is a tab route
  /// and pushing an appropriate RootRoute or using regular path navigation
  Future<void> pushNamed(String uri) async {
    final uriPath = uri.split("?").first;
    final basePath = uriPath.split("/").where((s) => s.isNotEmpty).firstOrNull ?? "";

    // Check if this is a tab route by trying to convert it
    final tabRoute = NavBarConfig.pathToRoute(uriPath);
    print("tabRoute: $tabRoute");
    // If it's a tab route, handle it specially
    if (tabRoute != null) {
      final navBarEnum = NavBarConfig.pathToTab(basePath);

      if (navBarEnum == null) {
        // Fallback to regular navigation
        await _router?.pushPath("/$uri");
        return;
      }

      // Check if we're already in a tab view
      final isCurrentlyWithinTabView = _isCurrentlyWithinTabView();
      print("isCurrentlyWithinTabView: $isCurrentlyWithinTabView");
      if (isCurrentlyWithinTabView) {
        print("pushing tabRoute");
        // If already in tab view, navigate within the existing tab structure
        await _router?.push(tabRoute);
      } else {
        print("pushing new RootRoute ${navBarEnum.name}");
        // If not in tab view, push a new RootRoute
        await _router?.push(
          RootRoute(initialTabToGetBackTo: navBarEnum, children: [tabRoute], isFirstRootBottomView: false),
        );
      }
      return;
    }

    // For non-tab routes, use regular path navigation
    final properlyWorkingURI = uri.startsWith("/") ? uri : "/$uri";
    await _router?.pushPath(properlyWorkingURI);
  }

  bool _isCurrentlyWithinTabView() {
    final lastRoute = ref.read(currentRouteProvider);
    final routeSettings = lastRoute?.settings;
    if (routeSettings is AutoRoutePage) {
      return routeSettings.routeData.name == RootRoute.name;
    }
    return false;
  }

  @override
  GlobalKey<AutoRouterState> build() {
    return GlobalKey<AutoRouterState>();
  }
}

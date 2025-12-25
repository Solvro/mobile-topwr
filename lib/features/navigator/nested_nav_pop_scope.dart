import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/nav_bar_config.dart";
import "../../services/pop_scope/use_block_pop.dart";
import "app_router.dart";
import "navigation_stack.dart";

/// This widgets navigates to home route if user is in tab view and pops route
/// Also resets entire stack if user is deeply nested and shows symptoms of a user who lost interest in stack history
/// This is fully Olcia custom navigation mode (with some other parts of the codebase)
class NestedNavPopScope extends HookConsumerWidget {
  const NestedNavPopScope({
    super.key,
    required this.initialTabToGetBackTo,
    required this.isFirstRootBottomView,
    required this.timesPushedToTabBar,
    required this.child,
  });
  final NavBarEnum initialTabToGetBackTo;
  final bool isFirstRootBottomView;
  final int timesPushedToTabBar;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only the topmost route should have a vote in pop behavior
    final myRoute = ModalRoute.of(context);
    final topRoute = ref.watch(currentRouteProvider);
    final isTopMostRoute = myRoute == topRoute;

    final tabsRouter = AutoTabsRouter.of(context);
    final currentRouteName = tabsRouter.currentChild?.name;
    final needsCustomPopAction =
        isTopMostRoute && ref.shouldNavigateBackToHome(currentRouteName, initialTabToGetBackTo);
    print("needsCustomPopAction: $needsCustomPopAction (isTopMostRoute: $isTopMostRoute)");
    print("================================================");
    useBlockPop(
      ref: ref,
      blockDefaultPop: needsCustomPopAction,
      onCustomPopAction: () {
        final userLeftNestedContextOfInterest =
            timesPushedToTabBar > 1 &&
            !isFirstRootBottomView; // if user is deep into the app (second root view) and uses tab bar more than once, we reset the stack back to home entirely once they pop. We assume they've lost interest in the old UX.
        print("userLeftNestedContextOfInterest: $userLeftNestedContextOfInterest");
        if (userLeftNestedContextOfInterest) {
          print("resetting stack to home");
          return unawaited(
            ref.read(appRouterProvider).replaceAll([
              RootRoute(children: const [HomeRoute()]),
            ], updateExistingRoutes: false), // resets stack
          );
        }
        print("navigating to initial tab");
        unawaited(
          ref.read(appRouterProvider).navigate(NavBarConfig.tabViews[initialTabToGetBackTo]!),
        ); // just simply navigates to the initial tab
      },
    );
    return child;
  }
}

extension on WidgetRef {
  bool shouldNavigateBackToHome(String? currentRouteName, NavBarEnum initialTab) {
    if (currentRouteName == null) return false;
    print("================================================");
    print("currentRouteName: $currentRouteName");
    // Check if current route is in routesWithinTabBar
    final routesWithinTabBar = read(appRouterProvider).routesWithinTabBar;
    final isLastRouteInTabBar = routesWithinTabBar.any((route) => route.name == currentRouteName);
    print("isLastRouteInTabBar: $isLastRouteInTabBar");
    // Map route name to NavBarEnum to compare with initialTab
    final currentTab = NavBarConfig.routeNameToTab(currentRouteName);
    print("currentTab: $currentTab");
    print("initialTab: $initialTab");
    return isLastRouteInTabBar && currentTab != null && currentTab != initialTab;
  }
}

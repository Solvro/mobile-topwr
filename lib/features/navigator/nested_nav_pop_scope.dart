import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/nav_bar_config.dart";
import "../../services/pop_scope/use_block_pop.dart";
import "app_router.dart";

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
    final tabsRouter = AutoTabsRouter.of(context);
    final needsCustomPopAction = ref.shouldNavigateBackToHome(initialTabToGetBackTo, tabsRouter.activeIndex);
    useBlockPop(
      ref: ref,
      blockDefaultPop: needsCustomPopAction,
      onCustomPopAction: () {
        final userLeftNestedContextOfInterest =
            timesPushedToTabBar > 1 &&
            !isFirstRootBottomView; // if user is deep into the app (second root view) and uses tab bar more than once, we reset the stack back to home entirely once they pop. We assume they've lost interest in the old UX.
        if (userLeftNestedContextOfInterest) {
          return unawaited(
            ref.read(appRouterProvider).replaceAll([
              RootRoute(children: const [HomeRoute()]),
            ], updateExistingRoutes: false), // resets stack
          );
        }
        unawaited(
          ref.read(appRouterProvider).navigate(NavBarConfig.tabViews[initialTabToGetBackTo]!),
        ); // just simply navigates to the initial tab
      },
    );
    return child;
  }
}

extension on WidgetRef {
  bool shouldNavigateBackToHome(NavBarEnum initialTab, int activeIndex) {
    final activeRoute = NavBarConfig.tabViews.values.toList()[activeIndex];
    final routesWithinTabBar = read(appRouterProvider).routesWithinTabBar;
    final isLastRouteInTabBar = routesWithinTabBar.any((route) => route.name == activeRoute.routeName);
    return isLastRouteInTabBar && activeIndex != initialTab.index;
  }
}

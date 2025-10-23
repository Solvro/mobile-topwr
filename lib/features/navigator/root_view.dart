import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/nav_bar_config.dart";
import "../../utils/unwaited_microtask.dart";
import "../../widgets/horizontal_symmetric_safe_area.dart";
import "../app_changelog/update_changelog_wrapper.dart";
import "../bottom_nav_bar/bottom_nav_bar.dart";
import "app_router.dart";

@RoutePage()
class RootView extends HookConsumerWidget {
  const RootView({super.key, this.initialTabToGetBackTo = NavBarEnum.home, this.isFirstRootBottomView = true});

  final NavBarEnum initialTabToGetBackTo;
  final bool isFirstRootBottomView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var shouldNavigateBackToHome = false;
    final timesPushedToTabBar = useState(0);
    return ShowEntryDialogWrapper(
      child: AutoTabsRouter(
        routes: NavBarConfig.tabViews.values.toList(),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          shouldNavigateBackToHome = ref.shouldNavigateBackToHome(initialTabToGetBackTo, tabsRouter.activeIndex);
          return PopScope(
            canPop: !shouldNavigateBackToHome,
            onPopInvokedWithResult: (didPop, _) {
              if (!didPop) {
                final enforceHomeRoute =
                    timesPushedToTabBar.value > 1 &&
                    !isFirstRootBottomView; // if user is deep into the app (second root view) and uses tab bar more than once, we reset the stack back to home entirely once they pop. We assume they've lost interest in the old UX.
                timesPushedToTabBar.value = 0;
                if (enforceHomeRoute) {
                  unwaitedMicrotask(
                    () => ref.read(appRouterProvider).replaceAll([
                      RootRoute(children: const [HomeRoute()]),
                    ], updateExistingRoutes: false),
                  );
                } else {
                  unwaitedMicrotask(
                    () => ref.read(appRouterProvider).navigate(NavBarConfig.tabViews[initialTabToGetBackTo]!),
                  );
                }
              }
            },
            child: HorizontalSymmetricSafeAreaScaffold(
              bottomNavigationBar: BottomNavBar(
                activeIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  timesPushedToTabBar.value++;
                  tabsRouter.setActiveIndex(index);
                },
              ),
              body: child,
            ),
          );
        },
      ),
    );
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

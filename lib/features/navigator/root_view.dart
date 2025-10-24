import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/nav_bar_config.dart";
import "../../widgets/horizontal_symmetric_safe_area.dart";
import "../app_changelog/update_changelog_wrapper.dart";
import "../bottom_nav_bar/bottom_nav_bar.dart";
import "app_router.dart";
import "utils/android_pop_bug_workaround.dart";

@RoutePage()
class RootView extends HookConsumerWidget {
  const RootView({super.key, this.initialTabToGetBackTo = NavBarEnum.home});

  final NavBarEnum initialTabToGetBackTo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specialPop = ref.androidSpecialPopTreatment;
    var shouldNavigateBackToHome = false;
    final timesPushedToTabBar = useState(0);
    return PopScope(
      canPop: !specialPop, // android pop bug workaround
      child: NavigatorPopHandler(
        onPopWithResult: specialPop
            ? (result) async {
                if (!shouldNavigateBackToHome) {
                  await ref.handleAndroidSpecialPop();
                }
              }
            : null,
        child: ShowEntryDialogWrapper(
          child: AutoTabsRouter.pageView(
            routes: NavBarConfig.tabViews.values.toList(),
            builder: (context, child, controller) {
              final tabsRouter = AutoTabsRouter.of(context);
              shouldNavigateBackToHome = ref.shouldNavigateBackToHome(initialTabToGetBackTo, tabsRouter.activeIndex);
              return PopScope(
                canPop: !shouldNavigateBackToHome,
                child: NavigatorPopHandler(
                  onPopWithResult: shouldNavigateBackToHome
                      ? (result) async {
                          final enforceHomeRoute = timesPushedToTabBar.value > 1;
                          timesPushedToTabBar.value = 0;
                          if (enforceHomeRoute) {
                            await ref.read(appRouterProvider).replaceAll([
                              RootRoute(children: const [HomeRoute()]),
                            ], updateExistingRoutes: false);
                          } else {
                            await ref.read(appRouterProvider).navigate(NavBarConfig.tabViews[initialTabToGetBackTo]!);
                          }
                        }
                      : null,
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
                ),
              );
            },
          ),
        ),
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

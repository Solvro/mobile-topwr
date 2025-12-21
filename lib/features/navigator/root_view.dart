import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/nav_bar_config.dart";
import "../../services/pop_scope/centralized_pop_scope.dart";
import "../../widgets/horizontal_symmetric_safe_area.dart";
import "../app_changelog/update_changelog_wrapper.dart";
import "../bottom_nav_bar/bottom_nav_bar.dart";
import "nested_nav_pop_scope.dart";

@RoutePage()
class RootView extends HookConsumerWidget {
  const RootView({super.key, this.initialTabToGetBackTo = NavBarEnum.home, this.isFirstRootBottomView = true});

  final NavBarEnum initialTabToGetBackTo;
  final bool isFirstRootBottomView;

  /// Converts route index to bottom nav bar index.
  /// Main tabs (0-4) keep their index, aliases (5+) map to buildings tab (index 1).
  static int _routeIndexToTabIndex(int routeIndex) =>
      routeIndex < NavBarEnum.values.length ? routeIndex : NavBarEnum.buildings.index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timesPushedToTabBar = useState(0);
    return ShowEntryDialogWrapper(
      child: AutoTabsRouter(
        routes: NavBarConfig.allTabRoutes,
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          final activeTabIndex = _routeIndexToTabIndex(tabsRouter.activeIndex);
          return CentralizedPopScope(
            child: NestedNavPopScope(
              initialTabToGetBackTo: initialTabToGetBackTo,
              isFirstRootBottomView: isFirstRootBottomView,
              timesPushedToTabBar: timesPushedToTabBar.value,
              child: HorizontalSymmetricSafeAreaScaffold(
                bottomNavigationBar: BottomNavBar(
                  activeIndex: activeTabIndex,
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
    );
  }
}

import '../../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../../bottom_nav_bar/nav_bar_config.dart';
import '../page_routes/detail_page_route.dart';
import 'nested_navigator.dart';

/// Extracted logic of navigating to tabs in tab view
extension TabBarNavigator on NestedNavigator {
  void changeTabBar(NavBarEnum newTab) {
    final currentTab = ref.read(bottomNavBarControllerProvider);
    if (currentTab == newTab) {
      return; // no action
    }

    navigatorKey.currentState?.popUntil(
      (route) => route.settings.name == AppRoutes.root,
    );

    navigatorKey.currentState?.pushNamed(
      AppRoutes.root,
      arguments: newTab,
    );
  }
}

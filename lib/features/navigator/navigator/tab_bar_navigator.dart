import "../../../config/nav_bar_config.dart";
import "../../../config/routes.dart";
import "../../bottom_nav_bar/bottom_nav_bar_controller.dart";
import "nested_navigator.dart";

/// Extracted logic of navigating to tabs in tab view
extension TabBarNavigator on NestedNavigator {
  Future<void> changeTabBar(NavBarEnum newTab) async {
    final currentTab = ref.read(bottomNavBarControllerProvider);
    if (currentTab != newTab) {
      navigatorKey.currentState?.popUntil(
        (route) => route.settings.name == AppRoutes.root,
      );

      await navigatorKey.currentState?.pushNamed(
        AppRoutes.root,
        arguments: newTab,
      );
    }
  }
}

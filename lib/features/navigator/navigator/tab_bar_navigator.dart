import '../../../config/nav_bar_config.dart';
import '../../../config/navigator_config.dart';
import '../../bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'nested_navigator.dart';

/// Extracted logic of navigating to tabs in tab view
extension TabBarNavigator on NestedNavigator {
  void changeTabBar(NavBarEnum newTab) {
    final currentTab = ref.read(bottomNavBarControllerProvider);
    if (currentTab != newTab) {
      navigatorKey.currentState?.popUntil(
        (route) => route.settings.name == AppRoutes.root,
      );

      navigatorKey.currentState?.pushNamed(
        AppRoutes.root,
        arguments: newTab,
      );
    }
  }
}

import "../../../config/nav_bar_config.dart";
import "../../../config/routes.dart";
import "nested_navigator.dart";
import "tab_bar_navigator.dart";

/// Extracted logic of navigating to detailed views
extension DetailViewNavigator on NestedNavigator {
  Future<void> navigateToStudyCircleDetails(String argument) async {
    await changeTabBar(NavBarEnum.sciCircles);
    await navigatorKey.currentState?.pushNamed(
      AppRoutes.studyCircleDetails,
      arguments: argument,
    );
  }

  Future<void> navigateToAboutUs() async {
    await changeTabBar(NavBarEnum.info);
    await navigatorKey.currentState?.pushNamed(AppRoutes.aboutUsDetail);
  }

  Future<void> navigateToDepartmentDetails(String argument) async {
    await changeTabBar(NavBarEnum.faculties);
    await navigatorKey.currentState?.pushNamed(
      AppRoutes.departmentDetails,
      arguments: argument,
    );
  }
}

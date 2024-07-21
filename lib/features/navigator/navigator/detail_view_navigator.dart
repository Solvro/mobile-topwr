import '../../../config/nav_bar_config.dart';
import '../../../config/routes.dart';
import 'nested_navigator.dart';
import 'tab_bar_navigator.dart';

/// Extracted logic of navigating to detailed views
extension DetailViewNavigator on NestedNavigator {
  void navigateToStudyCircleDetails(String argument) {
    changeTabBar(NavBarEnum.sciCircles);
    navigatorKey.currentState?.pushNamed(
      AppRoutes.studyCircleDetails,
      arguments: argument,
    );
  }

  void navigateToAboutUs() {
    changeTabBar(NavBarEnum.info);
    navigatorKey.currentState?.pushNamed(AppRoutes.aboutUsDetail);
  }

  void navigateToDepartmentDetails(String argument) {
    changeTabBar(NavBarEnum.faculties);
    navigatorKey.currentState?.pushNamed(
      AppRoutes.departmentDetails,
      arguments: argument,
    );
  }
}

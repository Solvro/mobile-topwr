import '../../../config/nav_bar_config.dart';
import '../page_routes/detail_page_route.dart';
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
}

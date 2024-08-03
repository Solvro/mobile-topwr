import "package:flutter_riverpod/flutter_riverpod.dart";

import "../app_router.dart";
import "../navigation_controller.dart";

/// just a one place to gather implementation details of navigation flow
/// - for easy maintainance
extension NavigationX on WidgetRef {
  NavigationController get _router =>
      read(navigationControllerProvider.notifier);

  Future<void> navigateHome() async {
    await _router.push(const HomeRoute());
  }

  Future<void> navigateBuildings() async {
    await _router.push(const BuildingMapRoute());
  }

  Future<void> navigateParkings() async {
    await _router.push(const ParkingsMapRoute());
  }

  Future<void> navigateDepartments() async {
    await _router.push(const DepartmentRoute());
  }

  Future<void> navigateDepartmentDetail(String id) async {
    await _router.push(DepartmentDetailsRoute(id: id));
  }

  Future<void> navigateSciClubs() async {
    await _router.push(const ScientificCirclesRoute());
  }

  Future<void> navigateSciClubsDetail(String id) async {
    await _router.push(StudyCircleDetailsRoute(id: id));
  }

  Future<void> navigateGuide() async {
    await _router.push(const GuideRouteTemplate());
  }

  Future<void> navigateAboutUs() async {
    await _router.push(const AboutUsRoute());
  }
}

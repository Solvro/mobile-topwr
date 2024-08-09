import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../buildings_view/controllers.dart";
import "../../buildings_view/model/building_model.dart";
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
    await _router.push(const BuildingsRoute());
  }

  Future<void> navigateBuilding(BuildingModel model) async {
    unawaited(_router.push(const BuildingsRoute()));
    watch(activeBuildingControllerProvider.notifier).selectItem(model);
  }

  Future<void> navigateParkings() async {
    await _router.push(const ParkingsRoute());
  }

  Future<void> navigateDepartments() async {
    await _router.push(const DepartmentsRoute());
  }

  Future<void> navigateDepartmentDetail(String id) async {
    await _router.push(DepartmentDetailRoute(id: id));
  }

  Future<void> navigateScienceClubs() async {
    await _router.push(const ScienceClubsRoute());
  }

  Future<void> navigateSciClubsDetail(String id) async {
    await _router.push(ScienceClubDetailRoute(id: id));
  }

  Future<void> navigateGuide() async {
    await _router.push(const GuideRoute());
  }

  Future<void> navigateAboutUs() async {
    await _router.push(const AboutUsRoute());
  }

  Future<void> navigateGuideDetail(String id) async {
    await _router.push(GuideDetailRoute(id: id));
  }
}

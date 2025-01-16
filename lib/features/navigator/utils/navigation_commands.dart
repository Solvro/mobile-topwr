import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:logger/logger.dart";

import "../../../utils/launch_url_util.dart";
import "../../buildings_view/model/building_model.dart";
import "../../digital_guide_view/tabs/adapted_toilets/data/models/adapted_toilet.dart";
import "../../digital_guide_view/tabs/rooms/data/models/digital_guide_room.dart";
import "../../parkings_view/models/parking.dart";
import "../app_router.dart";
import "../navigation_controller.dart";

/// just a one place to gather implementation details of navigation flow
/// - for easy maintenance
extension NavigationX on WidgetRef {
  NavigationController get _router =>
      read(navigationControllerProvider.notifier);

  Future<void> navigateHome() async {
    await _router.push(const HomeRoute());
  }

  Future<void> navigateBuildings(BuildingModel? initialActiveModel) async {
    await _router.push(BuildingsRoute());
  }

  Future<void> navigateBuilding(BuildingModel model) async {
    await _router.push(BuildingsRoute(initialActiveItemId: model.id));
  }

  Future<void> navigateParkings() async {
    await _router.push(ParkingsRoute());
  }

  Future<void> navigateParking(Parking model) async {
    await _router.push(ParkingsRoute(initialActiveItemId: model.id));
  }

  Future<void> navigateDepartments() async {
    await _router.push(const DepartmentsRoute());
  }

  Future<void> navigateDepartmentDetail(String id) async {
    await _router.push(DepartmentDetailRoute(id: id));
  }

  Future<void> navigateScienceClubs() async {
    await _router.push(ScienceClubsRoute());
  }

  Future<void> navigateScienceClub(String? departmentFilterId) async {
    await _router.push(
      ScienceClubsRoute(
        deptsIdsSequence: departmentFilterId,
      ),
    );
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

  Future<void> navigateNamedUri(String uri) async {
    await _router.pushNamed(uri);
  }

  Future<void> navigateToSksMenu() async {
    await _router.push(const SksMenuRoute());
  }

  Future<void> navigateDigitalGuide(String ourId) async {
    await _router.push(DigitalGuideRoute(ourId: ourId));
  }

  Future<void> navigateAdaptedToiletDetails(AdaptedToilet adaptedToilet) async {
    await _router.push(AdaptedToiletDetailRoute(adaptedToilet: adaptedToilet));
  }

  Future<void> navigateRoomDetails(DigitalGuideRoom room) async {
    await _router.push(DigitalGuideRoomDetailRoute(room: room));
  }

  Future<void> navigateBuildingDetailAction(BuildingModel building) async {
    return switch (building.externalDigitalGuideMode) {
      "web_url" => launch(building.externalDigitalGuideIdOrURL!),
      "digital_guide_building" => navigateDigitalGuide(building.id),
      "digital_guide_other_place" => Logger().i(
          "Other Digital Guide place, not yet implemented",
        ),
      _ => Logger().w(
          "Unknown externalDigitalGuideMode: ${building.externalDigitalGuideMode}",
        )
    };
  }
}

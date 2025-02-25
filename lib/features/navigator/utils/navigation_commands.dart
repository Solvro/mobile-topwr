import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:logger/logger.dart";

import "../../../utils/launch_url_util.dart";
import "../../buildings_view/model/building_model.dart";
import "../../digital_guide/data/models/level.dart" as digital_guide;
import "../../digital_guide/data/models/level_with_regions.dart";
import "../../digital_guide/data/models/region.dart";
import "../../digital_guide/tabs/adapted_toilets/data/models/adapted_toilet.dart";
import "../../digital_guide/tabs/entraces/data/models/digital_guide_entrace.dart";
import "../../digital_guide/tabs/lifts/data/models/digital_guide_lift.dart";
import "../../digital_guide/tabs/micronavigation/data/models/micronavigation_response.dart";
import "../../digital_guide/tabs/rooms/data/models/digital_guide_room.dart";
import "../../digital_guide/tabs/structure/data/models/corridor.dart";
import "../../digital_guide/tabs/structure/data/models/stairs.dart";
import "../../digital_guide/tabs/structure/data/models/toilet.dart";
import "../../digital_guide/tabs/transportation/data/models/digital_guide_transportation.dart";
import "../../parkings/parkings_view/models/parking.dart";
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

  Future<void> navigateDigitalGuide(
    String ourId,
    BuildingModel building,
  ) async {
    await _router.push(DigitalGuideRoute(ourId: ourId, building: building));
  }

  Future<void> navigateDigitalGuideObject(
    String ourId,
    BuildingModel building,
  ) async {
    await _router
        .push(DigitalGuideObjectRoute(ourId: ourId, building: building));
  }

  Future<void> navigateAdaptedToiletDetails(AdaptedToilet adaptedToilet) async {
    await _router.push(AdaptedToiletDetailRoute(adaptedToilet: adaptedToilet));
  }

  Future<void> navigateMicronavigationDetails(
    MicronavigationResponse micronavigationResponse,
  ) async {
    await _router.push(
      MicronavigationDetailRoute(
        micronavigationResponse: micronavigationResponse,
      ),
    );
  }

  Future<void> navigateRoomDetails(DigitalGuideRoom room) async {
    await _router.push(DigitalGuideRoomDetailRoute(room: room));
  }

  Future<void> navigateEntrancesDetails(DigitalGuideEntrace entrance) async {
    await _router.push(DigitalGuideEntranceDetailsRoute(entrance: entrance));
  }

  Future<void> navigateTransportDetails({
    required DigitalGuideTransportation transportation,
    required bool isPublic,
  }) async {
    await _router.push(
      TransportationDetailRoute(
        transportation: transportation,
        isPublic: isPublic,
      ),
    );
  }

  Future<void> navigateLiftDetails(
    DigitalGuideLift lift,
    String levelName,
  ) async {
    await _router
        .push(DigitalGuideLiftDetailRoute(lift: lift, levelName: levelName));
  }

  Future<void> navigateDigitalGuideLevel(LevelWithRegions levelInfo) async {
    await _router.push(LevelRoute(levelInfo: levelInfo));
  }

  Future<void> navigateDigitalGuideRegion(
    digital_guide.Level level,
    Region region,
  ) async {
    await _router.push(
      RegionRoute(
        level: level,
        region: region,
      ),
    );
  }

  Future<void> navigateDigitalGuideCorridor(Corridor corridor) async {
    await _router.push(CorridorRoute(corridor: corridor));
  }

  Future<void> navigateDigitalGuideStairs(Stairs stairs) async {
    await _router.push(StairsRoute(stairs: stairs));
  }

  Future<void> navigateDigitalGuideToilets(Toilet toilet) async {
    await _router.push(ToiletsRoute(toilet: toilet));
  }

  Future<void> navigateDigitalGuideDoor(int doorID) async {
    await _router.push(DoorRoute(doorsID: doorID));
  }

  Future<void> navigateDigitalGuideRailing(int railingId) async {
    await _router.push(RailingsRoute(railingId: railingId));
  }

  Future<void> navigateBuildingDetailAction(BuildingModel building) async {
    return switch (building.externalDigitalGuideMode) {
      "web_url" => launch(building.externalDigitalGuideIdOrURL!),
      "digital_guide_building" => navigateDigitalGuide(building.id, building),
      "other_digital_guide_place" =>
        navigateDigitalGuideObject(building.id, building),
      _ => Logger().w(
          "Unknown externalDigitalGuideMode: ${building.externalDigitalGuideMode}",
        )
    };
  }
}

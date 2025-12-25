import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:logger/logger.dart";

import "../../../config/nav_bar_config.dart";
import "../../../utils/launch_url_util.dart";
import "../../analytics/data/clarity.dart";
import "../../analytics/data/clarity_events.dart";
import "../../branches/business/selected_branch_on_map.dart";
import "../../branches/data/model/branch.dart";
import "../../map_layer_picker/data/layer_options.dart";
import "../../map_layer_picker/data/local_layers_repository.dart";
import "../../digital_guide/data/models/level.dart" as digital_guide;
import "../../digital_guide/data/models/level_with_regions.dart";
import "../../digital_guide/data/models/region.dart";
import "../../digital_guide/tabs/adapted_toilets/data/models/adapted_toilet.dart";
import "../../digital_guide/tabs/dressing_room/data/models/digital_guide_dressing_room.dart";
import "../../digital_guide/tabs/entraces/data/models/digital_guide_entrace.dart";
import "../../digital_guide/tabs/information_points/models/digital_guide_information_points.dart";
import "../../digital_guide/tabs/lifts/data/models/digital_guide_lift.dart";
import "../../digital_guide/tabs/lodge/data/models/digital_guide_lodge.dart";
import "../../digital_guide/tabs/micronavigation/data/models/micronavigation_response.dart";
import "../../digital_guide/tabs/rooms/data/models/digital_guide_room.dart";
import "../../digital_guide/tabs/structure/data/models/corridor.dart";
import "../../digital_guide/tabs/structure/data/models/parking.dart";
import "../../digital_guide/tabs/structure/data/models/ramp.dart";
import "../../digital_guide/tabs/structure/data/models/stairway.dart";
import "../../digital_guide/tabs/structure/data/models/toilet.dart";
import "../../digital_guide/tabs/transportation/data/models/digital_guide_transportation.dart";
import "../../multilayer_map/data/model/building.dart";
import "../../parkings/parkings_view/models/parking.dart";
import "../../science_club/science_clubs_view/model/science_clubs.dart" show ScienceClub;
import "../../science_club/science_clubs_view/repository/science_clubs_repository.dart";
import "../app_router.dart";
import "../navigation_controller.dart";

/// just a one place to gather implementation details of navigation flow
/// - for easy maintenance
extension NavigationX on WidgetRef {
  NavigationController get _router => read(navigationControllerProvider.notifier);

  Future<void> navigateHome() async {
    await _router.push(const HomeRoute());
  }

  Future<void> navigateBuildings(Building? initialActiveModel) async {
    if (initialActiveModel != null) {
      await trackEvent(ClarityEvents.selectBuilding, value: initialActiveModel.name);
    }
    await _router.push(BuildingsRoute());
  }

  Future<void> navigateBuilding(Building model) async {
    await trackEvent(ClarityEvents.selectBuilding, value: model.name);
    await _router.push(BuildingsRoute(initialActiveItemId: model.id));
  }

  Future<void> navigateParkings() async {
    await _router.push(ParkingsRoute());
  }

  Future<void> navigateParking(Parking model) async {
    await trackEvent(ClarityEvents.openParkingChart, value: model.nameNormalized);
    await _router.push(ParkingsRoute(initialActiveItemId: model.id));
  }

  Future<void> navigateDepartments() async {
    await trackEvent(ClarityEvents.openDepartmentsList);
    await _router.push(DepartmentsRoute());
  }

  Future<void> navigateDepartmentDetail(int id) async {
    await trackEvent(ClarityEvents.openDepartmentDetail, value: id.toString());
    await _router.push(DepartmentDetailRoute(id: id));
  }

  Future<void> navigateScienceClubs([String? departmentFilterId]) async {
    if (departmentFilterId != null) {
      await trackEvent(ClarityEvents.openSciClubsList, value: "filtered by department: $departmentFilterId");
    } else {
      await trackEvent(ClarityEvents.openSciClubsList);
    }
    await _router.push(ScienceClubsRoute(deptsIdsSequence: departmentFilterId));
  }

  Future<void> navigateSciClubsDetail(ScienceClub model) async {
    await trackEvent(ClarityEvents.openScienceClubDetail, value: model.id.toString());
    if (model.isSolvro) {
      // solvro science club
      await trackEvent(ClarityEvents.openSolvroScienceClubDetailPage, value: "Solvro: ${model.id}");
    }
    await _router.push(ScienceClubDetailRoute(id: model.id));
  }

  Future<void> navigateGuide() async {
    await _router.push(const GuideRoute());
  }

  Future<void> navigateAboutUs() async {
    await trackEvent(ClarityEvents.openAboutUs);
    await _router.push(const AboutUsRoute());
  }

  Future<void> navigateGuideDetail(int id) async {
    await trackEvent(ClarityEvents.openGuideArticleDetail, value: id.toString());
    await _router.push(GuideDetailRoute(id: id));
  }

  Future<void> navigateNamedUri(String uri) async {
    _maybeResetMapStateForDeeplink(uri);
    await _router.pushNamed(uri);
  }

  /// Resets map state for multilayer map deeplinks:
  /// - Sets campus to main (other campuses not supported yet)
  /// - Enables all layer types
  void _maybeResetMapStateForDeeplink(String uri) {
    final basePath = uri.split("?").first.split("/").where((s) => s.isNotEmpty).firstOrNull ?? "";
    if (!NavBarConfig.buildingsTabPaths.contains(basePath)) return;

    read(selectedBranchOnMapProvider.notifier).setBranch(Branch.main);
    for (final option in topLevelLayerOptions) {
      unawaited(read(localLayersRepositoryProvider(option).notifier).setMode(newValue: true));
    }
  }

  Future<void> navigateToSksMenu() async {
    await trackEvent(ClarityEvents.openSksMenu);
    await _router.push(const SksMenuRoute());
  }

  Future<void> navigateToSksFavouriteDishes() async {
    await trackEvent(ClarityEvents.openSksFavouriteDishes);
    await _router.push(const SksFavouriteDishesRoute());
  }

  Future<void> navigateSettings() async {
    await trackEvent(ClarityEvents.openSettings);
    await _router.push(const SettingsRoute());
  }

  Future<void> navigateDigitalGuide(String ourId, Building building) async {
    await trackEvent(ClarityEvents.openDigitalGuideDetail, value: "ourId: $ourId, building: ${building.name}");
    await _router.push(DigitalGuideRoute(ourId: ourId, building: building));
  }

  Future<void> navigateDigitalGuideObject(String ourId, Building building) async {
    await trackEvent(ClarityEvents.openDigitalGuideDetail, value: "ourId: $ourId, building: ${building.name}. Obj.");
    await _router.push(DigitalGuideObjectRoute(ourId: ourId, building: building));
  }

  Future<void> navigateAdaptedToiletDetails(AdaptedToilet adaptedToilet) async {
    await trackEvent(
      ClarityEvents.openDigitalGuideSubscreen,
      value: "adaptedToilet: ${adaptedToilet.translations.plTranslation.location}",
    );
    await _router.push(AdaptedToiletDetailRoute(adaptedToilet: adaptedToilet));
  }

  Future<void> navigateMicronavigationDetails(MicronavigationResponse micronavigationResponse) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "micronavigation: ${micronavigationResponse.id}");
    await _router.push(MicronavigationDetailRoute(micronavigationResponse: micronavigationResponse));
  }

  Future<void> navigateRoomDetails(DigitalGuideRoom room) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "room: ${room.id}");
    await _router.push(DigitalGuideRoomDetailRoute(room: room));
  }

  Future<void> navigateEntrancesDetails(DigitalGuideEntrace entrance) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "entrance: ${entrance.id}");
    await _router.push(DigitalGuideEntranceDetailsRoute(entrance: entrance));
  }

  Future<void> navigateTransportDetails({
    required DigitalGuideTransportation transportation,
    required bool isPublic,
  }) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "transport: ${transportation.id}");
    await _router.push(TransportationDetailRoute(transportation: transportation, isPublic: isPublic));
  }

  Future<void> navigateLiftDetails(DigitalGuideLift lift, String levelName) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "lift: ${lift.id}");
    await _router.push(DigitalGuideLiftDetailRoute(lift: lift, levelName: levelName));
  }

  Future<void> navigateDigitalGuideLevel(LevelWithRegions levelInfo) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "level: ${levelInfo.level.id}");
    await _router.push(LevelRoute(levelInfo: levelInfo));
  }

  Future<void> navigateDigitalGuideRegion(digital_guide.Level level, Region region) async {
    await trackEvent(
      ClarityEvents.openDigitalGuideSubscreen,
      value: "region: ${region.translations.plTranslation.name}",
    );
    await _router.push(RegionRoute(level: level, region: region));
  }

  Future<void> navigateDigitalGuideCorridor(Corridor corridor) async {
    await trackEvent(
      ClarityEvents.openDigitalGuideSubscreen,
      value: "corridor: ${corridor.translations.plTranslation.name}",
    );
    await _router.push(CorridorRoute(corridor: corridor));
  }

  Future<void> navigateDigitalGuideStairs(int stairsId) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "stairs: $stairsId");
    await _router.push(StairsRoute(stairsId: stairsId));
  }

  Future<void> navigateDigitalGuideStairway(Stairway stairway) async {
    await trackEvent(
      ClarityEvents.openDigitalGuideSubscreen,
      value: "stairway: ${stairway.translations.plTranslation.name}",
    );
    await _router.push(StairwayRoute(stairway: stairway));
  }

  Future<void> navigateDigitalGuideRamps(Ramp ramps) async {
    await trackEvent(
      ClarityEvents.openDigitalGuideSubscreen,
      value: "ramps: ${ramps.translations.plTranslation.location}",
    );
    await _router.push(RampsRoute(ramps: ramps));
  }

  Future<void> navigateDigitalGuideToilet(Toilet toilet) async {
    await trackEvent(
      ClarityEvents.openDigitalGuideSubscreen,
      value: "toilet: ${toilet.translations.plTranslation.location}",
    );
    await _router.push(ToiletsRoute(toilet: toilet));
  }

  Future<void> navigateDigitalGuideDoor(int doorID) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "door: $doorID");
    await _router.push(DoorRoute(doorsID: doorID));
  }

  Future<void> navigateDigitalGuideRailing(int railingId) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "railing: $railingId");
    await _router.push(RailingsRoute(railingId: railingId));
  }

  Future<void> navigateDigitalGuideLodge(DigitalGuideLodge lodge) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "lodge: ${lodge.id}");
    await _router.push(LodgeRoute(lodge: lodge));
  }

  Future<void> navigateDigitalGuideInformationPoint(DigitalGuideInformationPoint informationPoint) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "informationPoint: ${informationPoint.id}");
    await _router.push(InformationPointRoute(informationPoint: informationPoint));
  }

  Future<void> navigateDigitalGuideDressingRoom(DigitalGuideDressingRoom dressingRoom) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "dressingRoom: ${dressingRoom.id}");
    await _router.push(DressingRoomRoute(dressingRoom: dressingRoom));
  }

  Future<void> navigateDigitalGuideParking(DigitalGuideParking parking) async {
    await trackEvent(ClarityEvents.openDigitalGuideSubscreen, value: "parking: ${parking.id}");
    await _router.push(ParkingRoute(parking: parking));
  }

  Future<void> navigateBuildingDetailAction(Building building) async {
    return switch (building.externalDigitalGuideMode) {
      ExternalDigitalGuideMode.webUrl => launch(building.externalDigitalGuideIdOrUrl!),
      ExternalDigitalGuideMode.digitalGuideBuilding => navigateDigitalGuide(building.id, building),
      ExternalDigitalGuideMode.otherDigitalGuidePlace => navigateDigitalGuideObject(building.id, building),
      null => Logger().w("ExternalDigitalGuideMode is null, but used navigateBuildingDetailAction"),
    };
  }

  Future<void> navigateNewsfeed() async {
    await _router.push(const NewsfeedRoute());
  }

  Future<void> navigateCalendar() async {
    await _router.push(CalendarRoute());
  }

  Future<void> navigateToRadioLuz() async {
    await _router.push(const RadioLuzRoute());
  }
}

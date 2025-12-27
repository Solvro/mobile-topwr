import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/nav_bar_config.dart";
import "../about_us_view/about_us_view.dart";
import "../calendar/presentation/calendar_view.dart";
import "../departments/department_detail_view/presentation/department_detail_view.dart";
import "../departments/departments_view/departments_view.dart";
import "../digital_guide/data/models/level.dart";
import "../digital_guide/data/models/level_with_regions.dart";
import "../digital_guide/data/models/region.dart";
import "../digital_guide/presentation/digital_guide_view.dart";
import "../digital_guide/tabs/adapted_toilets/data/models/adapted_toilet.dart";
import "../digital_guide/tabs/adapted_toilets/presentation/adapted_toilet_detail_view.dart";
import "../digital_guide/tabs/doors/presentation/door_view.dart";
import "../digital_guide/tabs/dressing_room/data/models/digital_guide_dressing_room.dart";
import "../digital_guide/tabs/entraces/data/models/digital_guide_entrace.dart";
import "../digital_guide/tabs/entraces/presentation/entraces_detail_view.dart";
import "../digital_guide/tabs/information_points/models/digital_guide_information_points.dart";
import "../digital_guide/tabs/lifts/data/models/digital_guide_lift.dart";
import "../digital_guide/tabs/lifts/presentation/digital_guide_lift_detail_view.dart";
import "../digital_guide/tabs/lodge/data/models/digital_guide_lodge.dart";
import "../digital_guide/tabs/micronavigation/data/models/micronavigation_response.dart";
import "../digital_guide/tabs/micronavigation/presentation/micronavigation_detail_view.dart";
import "../digital_guide/tabs/rooms/data/models/digital_guide_room.dart";
import "../digital_guide/tabs/rooms/presentation/digital_guide_room_detail_view.dart";
import "../digital_guide/tabs/structure/data/models/corridor.dart";
import "../digital_guide/tabs/structure/data/models/parking.dart";
import "../digital_guide/tabs/structure/data/models/ramp.dart";
import "../digital_guide/tabs/structure/data/models/stairway.dart";
import "../digital_guide/tabs/structure/data/models/toilet.dart";
import "../digital_guide/tabs/structure/presentation/views/corridor_view.dart";
import "../digital_guide/tabs/structure/presentation/views/dressing_room_view.dart";
import "../digital_guide/tabs/structure/presentation/views/information_point_view.dart";
import "../digital_guide/tabs/structure/presentation/views/level_view.dart";
import "../digital_guide/tabs/structure/presentation/views/lodge_view.dart";
import "../digital_guide/tabs/structure/presentation/views/parking_view.dart";
import "../digital_guide/tabs/structure/presentation/views/railings_view.dart";
import "../digital_guide/tabs/structure/presentation/views/ramps_view.dart";
import "../digital_guide/tabs/structure/presentation/views/region_view.dart";
import "../digital_guide/tabs/structure/presentation/views/stairs_view.dart";
import "../digital_guide/tabs/structure/presentation/views/stairway_view.dart";
import "../digital_guide/tabs/structure/presentation/views/toilets_view.dart";
import "../digital_guide/tabs/transportation/data/models/digital_guide_transportation.dart";
import "../digital_guide/tabs/transportation/presentation/transportation_detail_view.dart";
import "../digital_guide_objects/presentation/digital_guide_object_view.dart";
import "../guide_detail_view/guide_detail_view.dart";
import "../guide_view/guide_view.dart";
import "../home_view/home_view.dart";
import "../multilayer_map/data/model/building.dart";
import "../multilayer_map/data/model/multilayer_section_type.dart";
import "../multilayer_map/presentation/views/multilayer_map_view.dart";
import "../multilayer_map/presentation/views/redirect_views.dart";
import "../navigation_tab_view/navigation_tab_view.dart";
import "../newsfeed/presentation/news_list_view.dart";
import "../parkings/parkings_view/parkings_view.dart";
import "../radio_luz/presentation/radio_luz_view.dart";
import "../science_club/science_club_detail_view/science_club_detail_view.dart";
import "../science_club/science_clubs_view/science_clubs_view.dart";
import "../settings/settings_view.dart";
import "../sks/sks_favourite_dishes/presentation/sks_favourite_dishes_view.dart";
import "../sks/sks_menu/presentation/sks_menu_screen.dart";
import "root_view.dart";

part "app_router.g.dart";
part "app_router.gr.dart";

class _NoTransitionRoute extends CustomRoute<void> {
  _NoTransitionRoute({required super.path, required super.page})
    : super(reverseDuration: Duration.zero, duration: Duration.zero, allowSnapshotting: false);
}

@AutoRouterConfig(replaceInRouteName: "View,Route")
class AppRouter extends RootStackRouter {
  final Ref ref;

  AppRouter({required this.ref});

  // These have bottom nav bar visible
  // also they need to handle in app deeplinks differently
  List<AutoRoute> get routesWithinTabBar => [
    _NoTransitionRoute(path: "", page: HomeRoute.page),
    _NoTransitionRoute(path: "buildings/:initialActiveItemId", page: BuildingsRoute.page),
    _NoTransitionRoute(path: "libraries/:initialActiveItemId", page: LibrariesRoute.page),
    _NoTransitionRoute(path: "aeds/:initialActiveItemId", page: AedsRoute.page),
    _NoTransitionRoute(path: "bicycle-showers/:initialActiveItemId", page: ShowersRoute.page),
    _NoTransitionRoute(path: "pink-boxes/:initialActiveItemId", page: PinkBoxesRoute.page),
    _NoTransitionRoute(path: "multilayer-map/:initialActiveItemId", page: MultilayerMapRoute.page),
    _NoTransitionRoute(path: "parkings/:initialActiveItemId", page: ParkingsRoute.page),
    _NoTransitionRoute(path: "guide", page: GuideRoute.page),
    _NoTransitionRoute(path: "navigation", page: NavigationTabRoute.page),
    // Redirects for routes without :initialActiveItemId parameter
    RedirectRoute(path: "buildings", redirectTo: "buildings/null"),
    RedirectRoute(path: "libraries", redirectTo: "libraries/null"),
    RedirectRoute(path: "aeds", redirectTo: "aeds/null"),
    RedirectRoute(path: "bicycle-showers", redirectTo: "bicycle-showers/null"),
    RedirectRoute(path: "pink-boxes", redirectTo: "pink-boxes/null"),
    RedirectRoute(path: "multilayer-map", redirectTo: "multilayer-map/null"),
    RedirectRoute(path: "parkings", redirectTo: "parkings/null"),
  ];

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: "/", page: RootRoute.page, children: routesWithinTabBar),
    AutoRoute(path: "/sks-menu", page: SksMenuRoute.page),
    AutoRoute(path: "/sks-favourite-dishes", page: SksFavouriteDishesRoute.page),
    AutoRoute(path: "/guide/:id", page: GuideDetailRoute.page),
    AutoRoute(path: "/departments", page: DepartmentsRoute.page),
    AutoRoute(path: "/departments/:id", page: DepartmentDetailRoute.page),
    AutoRoute(path: "/sci-clubs", page: ScienceClubsRoute.page),
    AutoRoute(path: "/sci-clubs/:id", page: ScienceClubDetailRoute.page),
    AutoRoute(path: "/aboutUs", page: AboutUsRoute.page),
    AutoRoute(path: "/digital-guide/:id", page: DigitalGuideRoute.page),
    AutoRoute(path: "/digital-guide-other/:id", page: DigitalGuideObjectRoute.page),
    AutoRoute(page: LevelRoute.page),
    AutoRoute(page: RegionRoute.page),
    AutoRoute(page: DigitalGuideLiftDetailRoute.page),
    AutoRoute(page: CorridorRoute.page),
    AutoRoute(page: DigitalGuideEntranceDetailsRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: StairsRoute.page),
    AutoRoute(page: StairwayRoute.page),
    AutoRoute(page: ToiletsRoute.page),
    AutoRoute(page: DigitalGuideRoomDetailRoute.page),
    AutoRoute(path: "/digital-guide/:id/micronavigation-details", page: MicronavigationDetailRoute.page),
    AutoRoute(page: DoorRoute.page),
    AutoRoute(page: TransportationDetailRoute.page),
    AutoRoute(page: RailingsRoute.page),
    AutoRoute(page: RampsRoute.page),
    AutoRoute(page: AdaptedToiletDetailRoute.page),
    AutoRoute(page: LodgeRoute.page),
    AutoRoute(page: InformationPointRoute.page),
    AutoRoute(page: DressingRoomRoute.page),
    AutoRoute(page: ParkingRoute.page),
    AutoRoute(path: "/news", page: NewsfeedRoute.page),
    AutoRoute(path: "/calendar", page: CalendarRoute.page),
    AutoRoute(path: "/radio-luz", page: RadioLuzRoute.page),
  ];
}

@riverpod
Raw<AppRouter> appRouter(Ref ref) {
  return AppRouter(ref: ref);
}

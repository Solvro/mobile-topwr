import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../features/bottom_nav_bar/bottom_nav_bar_icon_icons.icons.dart";
import "../features/navigator/app_router.dart";
import "../features/parkings/parkings_view/widgets/parkings_icons.icons.dart";
import "../utils/context_extensions.dart";

enum NavBarEnum {
  home(BottomNavBarIcons.home_icon, 26, "Home"),
  buildings(BottomNavBarIcons.map_icon, 20, "Map"),
  parkings(ParkingsIcons.directions_car, 19, "Parkings"),
  guide(BottomNavBarIcons.info_icon, 22, "Guide"),
  navigation(BottomNavBarIcons.view_grid, 26, "Navigation Tab");

  const NavBarEnum(this.icon, this.size, this.label);

  final IconData icon;
  final double size;
  final String label;
}

abstract class NavBarConfig {
  static final tabViews = <NavBarEnum, PageRouteInfo>{
    NavBarEnum.home: const HomeRoute(),
    NavBarEnum.buildings: BuildingsRoute(),
    NavBarEnum.parkings: ParkingsRoute(),
    NavBarEnum.guide: const GuideRoute(),
    NavBarEnum.navigation: const NavigationTabRoute(),
  };

  // same but reversed key-value pairs
  static Map<String, NavBarEnum> get reversedTabViews =>
      Map.fromEntries(tabViews.entries.map((e) => MapEntry(e.value.routeName, e.key)));
}

extension GetFormattedRouteNameX on Route<dynamic> {
  String? getFormattedRouteName(BuildContext context) {
    return switch (settings.name) {
      HomeRoute.name => context.localize.home_screen,
      NavigationTabRoute.name => context.localize.other_view,
      DepartmentsRoute.name => context.localize.departments,
      SksMenuRoute.name => context.localize.sks_menu,
      ScienceClubsRoute.name => context.localize.scientific_cirlces,
      GuideRoute.name => context.localize.guide,
      BuildingsRoute.name => context.localize.buildings_title,
      ParkingsRoute.name => context.localize.parkings_title,
      DepartmentDetailRoute.name => context.localize.department,
      ScienceClubDetailRoute.name => context.localize.scientific_cirlces,
      GuideDetailRoute.name => context.localize.guide,
      DigitalGuideRoute.name => context.localize.digital_guide,
      LevelRoute.name => context.localize.level,
      RegionRoute.name => context.localize.region,
      CorridorRoute.name => context.localize.corridor,
      AdaptedToiletDetailRoute.name => context.localize.adapted_toilets,
      DigitalGuideEntranceDetailsRoute.name => context.localize.entrances,
      DigitalGuideRoomDetailRoute.name => context.localize.room_information,
      SettingsRoute.name => context.localize.settings,
      _ => null,
    };
  }
}

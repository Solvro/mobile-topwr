import "package:auto_route/auto_route.dart";
import "package:collection/collection.dart";
import "package:flutter/material.dart";

import "../features/bottom_nav_bar/bottom_nav_bar_icon_icons.icons.dart";
import "../features/navigator/app_router.dart";
import "../features/parkings_view/widgets/parkings_icons.icons.dart";

enum NavBarEnum {
  home(BottomNavBarIcon.home_icon, 26, "Home"),
  buildings(BottomNavBarIcon.map_icon, 20, "Map"),
  parkings(ParkingsIcons.directions_car, 19, "Parkings"),
  departments(BottomNavBarIcon.faculty_icon, 26, "Faculties"),
  scienceClubs(BottomNavBarIcon.sci_circle_icon, 20, "Science Clubs"),
  guide(BottomNavBarIcon.info_icon, 20, "Info");

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
    NavBarEnum.departments: const DepartmentsRoute(),
    NavBarEnum.scienceClubs: ScienceClubsRoute(),
    NavBarEnum.guide: const GuideRoute(),
  };
}

extension IsRouteATabViewOnStringX on String {
  NavBarEnum? get tabBarEnum => NavBarConfig.tabViews.entries
      .firstWhereOrNull((entry) => entry.value.routeName == this)
      ?.key;

  bool get isTabView =>
      NavBarConfig.tabViews.values.map((i) => i.routeName).contains(this);
}

extension IsRouteATabViewX on PageRouteInfo<dynamic> {
  NavBarEnum? get tabBarEnum => routeName.tabBarEnum;

  bool get isTabView => routeName.isTabView;
}

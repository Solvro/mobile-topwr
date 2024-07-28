import "package:auto_route/auto_route.dart";
import "package:collection/collection.dart";
import "package:enum_map/enum_map.dart";
import "package:flutter/material.dart";

import "../features/bottom_nav_bar/bottom_nav_bar_icon_icons.icons.dart";
import "../features/iparking/widgets/i_parking_icons_icons.icons.dart";
import "../features/navigator/app_router.dart";

part "nav_bar_config.g.dart";

@unmodifiableEnumMap
enum NavBarEnum {
  home(BottomNavBarIcon.home_icon, 26, "Home"),
  mapp(BottomNavBarIcon.map_icon, 20, "Map"),
  parkings(IParkingIcons.directions_car, 19, "Parkings"),
  faculties(BottomNavBarIcon.faculty_icon, 26, "Faculties"),
  sciCircles(BottomNavBarIcon.sci_circle_icon, 20, "Scientific Circles"),
  info(BottomNavBarIcon.info_icon, 20, "Info");

  const NavBarEnum(this.icon, this.size, this.label);

  final IconData icon;
  final double size;
  final String label;
}

abstract class NavBarConfig {
  static const tabViews = UnmodifiableNavBarEnumMap(
    home: HomeRoute(),
    mapp: BuildingMapRoute(),
    parkings: ParkingsMapRoute(),
    faculties: DepartmentRoute(),
    sciCircles: ScientificCirclesRoute(),
    info: GuideRouteTemplate(),
  );
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

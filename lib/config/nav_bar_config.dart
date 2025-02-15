import "package:auto_route/auto_route.dart";
import "package:collection/collection.dart";
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
}

extension IsRouteATabViewOnStringX on String {
  NavBarEnum? get tabBarEnum => NavBarConfig.tabViews.entries
      .firstWhereOrNull((entry) => entry.value.routeName == this)
      ?.key;

  bool get isTabView =>
      NavBarConfig.tabViews.values.map((i) => i.routeName).contains(this);

  bool get isRouteGlobalRoute => this == RootRoute.name;
}

extension IsRouteATabViewX on PageRouteInfo<dynamic> {
  NavBarEnum? get tabBarEnum => routeName.tabBarEnum;

  bool get isTabView => routeName.isTabView;

  bool get isRouteGlobalRoute => routeName.isRouteGlobalRoute;

  String? getFormatedRouteName(BuildContext context) {
    return switch (routeName) {
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
      _ => null,
    };
  }
}

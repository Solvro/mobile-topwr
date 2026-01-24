import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../features/bottom_nav_bar/bottom_nav_bar_icon_icons.icons.dart";
import "../features/navigator/app_router.dart";
import "../features/parkings/parkings_view/widgets/parkings_icons.icons.dart";
import "../utils/context_extensions.dart";

enum NavBarEnum {
  home(BottomNavBarIcons.home_icon, 26),
  buildings(BottomNavBarIcons.map_icon, 20),
  parkings(ParkingsIcons.directions_car, 19),
  guide(BottomNavBarIcons.info_icon, 22),
  navigation(BottomNavBarIcons.view_grid, 26);

  const NavBarEnum(this.icon, this.size);

  final IconData icon;
  final double size;

  String getLabel(BuildContext context) {
    return switch (this) {
      NavBarEnum.home => context.localize.nav_home,
      NavBarEnum.buildings => context.localize.nav_map,
      NavBarEnum.parkings => context.localize.nav_parkings,
      NavBarEnum.guide => context.localize.nav_guide,
      NavBarEnum.navigation => context.localize.nav_others,
    };
  }
}

abstract class NavBarConfig {
  /// Main tab views - one per bottom nav bar item
  static final tabViews = <NavBarEnum, PageRouteInfo>{
    NavBarEnum.home: const HomeRoute(),
    NavBarEnum.buildings: BuildingsRoute(),
    NavBarEnum.parkings: ParkingsRoute(),
    NavBarEnum.guide: const GuideRoute(),
    NavBarEnum.navigation: const NavigationTabRoute(),
  };

  /// Additional routes that appear within the tab bar (as multilayer map aliases)
  /// All of these map to the buildings tab
  static List<PageRouteInfo> get multilayerAliasRoutes => [
    LibrariesRoute(),
    AedsRoute(),
    ShowersRoute(),
    PinkBoxesRoute(),
    MultilayerMapRoute(),
  ];

  /// Route names that map to the buildings tab (used for reverse lookups)
  static const multilayerAliasRouteNames = {
    BuildingsRoute.name,
    LibrariesRoute.name,
    AedsRoute.name,
    ShowersRoute.name,
    PinkBoxesRoute.name,
    MultilayerMapRoute.name,
  };

  /// URL paths that map to the buildings tab
  static const buildingsTabPaths = {
    "buildings",
    "libraries",
    "aeds",
    "bicycle-showers",
    "pink-boxes",
    "multilayer-map",
  };

  /// All routes for AutoTabsRouter (main tabs + multilayer aliases)
  static List<PageRouteInfo> get allTabRoutes => [...tabViews.values, ...multilayerAliasRoutes];

  static bool isTabAMapView(int activeTabIndex) =>
      activeTabIndex == NavBarEnum.buildings.index || activeTabIndex == NavBarEnum.parkings.index;

  /// Maps a route name to its NavBarEnum
  static NavBarEnum? routeNameToTab(String? routeName) {
    if (routeName == null) return null;
    // Check main tabs first
    final mainTab = reversedTabViews[routeName];
    if (mainTab != null) return mainTab;
    // Check multilayer aliases (all map to buildings)
    if (multilayerAliasRouteNames.contains(routeName)) return NavBarEnum.buildings;
    return null;
  }

  /// Maps a URL base path to its NavBarEnum
  static NavBarEnum? pathToTab(String basePath) {
    return switch (basePath) {
      "" => NavBarEnum.home,
      "parkings" => NavBarEnum.parkings,
      "guide" => NavBarEnum.guide,
      "navigation" => NavBarEnum.navigation,
      _ when buildingsTabPaths.contains(basePath) => NavBarEnum.buildings,
      _ => null,
    };
  }

  /// Converts a URL path to a PageRouteInfo for routes within the tab bar
  static PageRouteInfo? pathToRoute(String path) {
    final cleanPath = path.startsWith("/") ? path.substring(1) : path;
    final segments = cleanPath.split("/");
    if (segments.isEmpty) return const HomeRoute();

    final basePath = segments[0];
    final itemId = segments.length > 1 && segments[1] != "null" ? segments[1] : null;

    return switch (basePath) {
      "" => const HomeRoute(),
      "buildings" => BuildingsRoute(initialActiveItemId: itemId),
      "libraries" => LibrariesRoute(initialActiveItemId: itemId),
      "aeds" => AedsRoute(initialActiveItemId: itemId),
      "bicycle-showers" => ShowersRoute(initialActiveItemId: itemId),
      "pink-boxes" => PinkBoxesRoute(initialActiveItemId: itemId),
      "multilayer-map" => MultilayerMapRoute(initialActiveItemId: itemId),
      "parkings" => ParkingsRoute(initialActiveItemId: itemId),
      "guide" => const GuideRoute(),
      "navigation" => const NavigationTabRoute(),
      _ => null,
    };
  }

  /// Reversed main tab views (route name -> NavBarEnum)
  static Map<String, NavBarEnum> get reversedTabViews =>
      Map.fromEntries(tabViews.entries.map((e) => MapEntry(e.value.routeName, e.key)));
}

extension GetFormattedRouteNameX on Route<dynamic> {
  String? getFormattedRouteName(BuildContext context) {
    return switch (settings.name) {
      RootRoute.name => switch ((context.router.childControllers.first as TabsRouter).currentChild?.name) {
        HomeRoute.name => context.localize.home_screen,
        NavigationTabRoute.name => context.localize.other_view,
        BuildingsRoute.name => context.localize.multilayer_map_title,
        ParkingsRoute.name => context.localize.parkings_title,
        MultilayerMapRoute.name => context.localize.multilayer_map_title,
        LibrariesRoute.name => context.localize.multilayer_map_title,
        AedsRoute.name => context.localize.multilayer_map_title,
        ShowersRoute.name => context.localize.multilayer_map_title,
        PinkBoxesRoute.name => context.localize.multilayer_map_title,
        GuideRoute.name => context.localize.guide,
        _ => null,
      },
      DepartmentsRoute.name => context.localize.departments,
      SksMenuRoute.name => context.localize.sks_menu,
      ScienceClubsRoute.name => context.localize.scientific_cirlces_short,
      DepartmentDetailRoute.name => context.localize.department,
      ScienceClubDetailRoute.name => context.localize.scientific_cirlces_short,
      GuideDetailRoute.name => context.localize.guide,
      DigitalGuideRoute.name => context.localize.digital_guide,
      LevelRoute.name => context.localize.level,
      RegionRoute.name => context.localize.region,
      CorridorRoute.name => context.localize.corridor,
      AdaptedToiletDetailRoute.name => context.localize.adapted_toilets,
      ToiletsRoute.name => context.localize.toilet,
      DigitalGuideEntranceDetailsRoute.name => context.localize.entrances,
      DigitalGuideRoomDetailRoute.name => context.localize.room_information,
      SettingsRoute.name => context.localize.settings,
      _ => null,
    };
  }
}

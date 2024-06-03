import 'package:flutter/material.dart';

import '../bottom_nav_bar/nav_bar_config.dart';
import 'utils/extract_tabbar_arg.dart';

class SelectedTabObserver extends RouteObserver<PageRoute<dynamic>> {
  void Function(NavBarEnum tab) onTabChanged;

  SelectedTabObserver(this.onTabChanged);

  void recordCurrentlySelectedTab(Route route) {
    final routesTabData = route.settings.selectedTab;
    if (routesTabData != null) {
      onTabChanged(routesTabData);
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    recordCurrentlySelectedTab(route);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    recordCurrentlySelectedTab(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      recordCurrentlySelectedTab(newRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    recordCurrentlySelectedTab(route);
  }
}

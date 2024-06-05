import 'package:flutter/material.dart';

import '../../../config/nav_bar_config.dart';
import 'extract_tabbar_arg.dart';

class SelectedTabObserver extends RouteObserver<PageRoute<dynamic>> {
  void Function(NavBarEnum tab) onTabChanged;

  /// Watches the changes of new navigation routes and calls onTabChanged
  SelectedTabObserver(this.onTabChanged);

  void _recordCurrentlySelectedTab(Route route) {
    final routesTabData = route.settings.selectedTab;
    if (routesTabData != null) {
      onTabChanged(routesTabData);
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _recordCurrentlySelectedTab(route);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (previousRoute != null) {
      _recordCurrentlySelectedTab(previousRoute);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _recordCurrentlySelectedTab(newRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _recordCurrentlySelectedTab(previousRoute);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/navigator_config.dart';
import '../../../config/routes.dart';
import '../../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../page_routes/detail_page_route.dart';
import '../page_routes/tabbar_page_route.dart';
import '../utils/android_pop_bug_workaround.dart';
import "../utils/extract_tabbar_arg.dart";

class NestedNavigator {
  NestedNavigator(this.ref);
  final Ref ref;
  final navigatorKey = GlobalKey<NavigatorState>();

  void handleNestedPop() {
    if (androidSpecialPopTreatment) {
      return handleAndroidSpecialPop();
    }
    navigatorKey.currentState?.maybePop();
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.root) {
      final previousTab = ref.read(bottomNavBarControllerProvider);
      return TabBarPageRoute(
        previousTab: previousTab,
        newTab: settings.selectedTab ?? NavigatorConfig.initialTab,
      );
    }
    return DetailPageRoute(settings);
  }
}

final navigatorProvider = Provider<NestedNavigator>((ref) {
  return NestedNavigator(ref);
});

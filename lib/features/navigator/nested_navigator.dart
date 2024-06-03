import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../bottom_nav_bar/nav_bar_config.dart';
import 'page_routes/tabbar_page_route.dart';
import 'page_routes/topwr_page_route.dart';
import 'utils/android_pop_bug_workaround.dart';
import "utils/extract_tabbar_arg.dart";

class NestedNavigator {
  NestedNavigator(this.ref);
  final Ref ref;
  final navigatorKey = GlobalKey<NavigatorState>();

  void handleNestedPop() {
    if (androidSpecialPopTreatment) {
      return handleAndroidSpecialPop();
    }
    navigatorKey.currentState?.pop();
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.root) {
      return TabbarPageRoute(
        settings.selectedTab,
        settings: settings,
      );
    }
    return TopwrPageRoute(settings);
  }

  void changeTabBar(NavBarEnum newTab) {
    final currentTab = ref.read(bottomNavBarControllerProvider);
    if (currentTab == newTab) {
      return; // no action
    }

    navigatorKey.currentState?.popUntil(
      (route) => route.settings.name == AppRoutes.root,
    );

    navigatorKey.currentState?.pushNamed(
      AppRoutes.root,
      arguments: newTab,
    );
  }

  void navigateToStudyCircleDetails(String argument) {
    changeTabBar(NavBarEnum.sciCircles);
    navigatorKey.currentState?.pushNamed(
      AppRoutes.studyCircleDetails,
      arguments: argument,
    );
  }
}

final navigatorProvider = Provider<NestedNavigator>((ref) {
  return NestedNavigator(ref);
});

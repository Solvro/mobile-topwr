import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../page_routes/tabbar_page_route.dart';
import '../page_routes/topwr_page_route.dart';
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
}

final navigatorProvider = Provider<NestedNavigator>((ref) {
  return NestedNavigator(ref);
});

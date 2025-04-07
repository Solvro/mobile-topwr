import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/nav_bar_config.dart";
import "../navigator/navigation_stack.dart";

part "bottom_nav_bar_controller.g.dart";

@riverpod
NavBarEnum bottomNavBarController(Ref ref) {
  final lastRoute = ref.watch(currentRouteProvider);
  final currentTab = NavBarConfig.reversedTabViews[lastRoute?.settings.name];
  if (currentTab == null) {
    final previousRoute = ref.watch(previousRouteProvider);
    return NavBarConfig.reversedTabViews[previousRoute?.settings.name] ?? NavBarEnum.home;
  }
  return currentTab;
}

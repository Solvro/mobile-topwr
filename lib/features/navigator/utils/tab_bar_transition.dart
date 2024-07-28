import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/nav_bar_config.dart";
import "../../../config/transitions.dart";
import "../../../utils/last_or_null.dart";
import "../navigation_controller.dart";

extension TabBarRouteTransitionBuilderX on Ref {
  RouteTransitionsBuilder tabBarTransitionBuilder(String thisRouteName) {
    return (a, b, c, d) {
      final previousTab = _getPreviousTab(thisRouteName)?.tabBarEnum;
      final thisTabBarEnum = thisRouteName.tabBarEnum;

      final isNewTabMoreToRight =
          (thisTabBarEnum?.index ?? 0) >= (previousTab?.index ?? 0);

      return isNewTabMoreToRight
          ? TransitionsConfig.slideLeftBuilder(a, b, c, d)
          : TransitionsConfig.slideRightBuilder(a, b, c, d);
    };
  }

  /// read navigator state and returns previous tab for the given one
  /// to compare and decide the transition direction (left or right)
  TRoute? _getPreviousTab(String thisRouteName) {
    final navigator = read(navigationControllerProvider.notifier);
    final stack = navigator.stack.toList();
    final didLastPop = navigator.didLastPop;
    final isThisLastRouteOnStack = stack.lastOrNull?.routeName == thisRouteName;
    return isThisLastRouteOnStack
        ? stack.preLastOrNull
        : didLastPop
            ? stack.lastOrNull
            : stack.prePreLastOrNull;
  }
}

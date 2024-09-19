import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/nav_bar_config.dart";

part "navigation_controller.g.dart";

typedef TRoute<T> = PageRouteInfo<T>;

typedef NavigationState = ({
  bool isStackPoppable,
  NavBarEnum activeTab,
});

@Riverpod(keepAlive: true)
class NavigationController extends _$NavigationController {
  final navigatorKey = GlobalKey<AutoRouterState>();

  StackRouter? get _router => navigatorKey.currentState?.controller;

  Iterable<TRoute> get _stack =>
      _router?.stackData.map((e) => e.route.toPageRouteInfo()) ?? [];

  Future<T?> push<T>(TRoute<T> route) async {
    return _router?.push(route);
  }

  /// this is called only when you actually **click** in the nav tab bar
  /// so we don't call this on other navigation actions (like `Lista >` buttons)
  Future<void> onTabBarChange(NavBarEnum item) async {
    final route = NavBarConfig.tabViews.get(item);
    if (_stack.last.routeName != route.routeName) {
      _popUntilTabBarView();
      await push(route);
    }
  }

  /// pops details views above tab views
  void _popUntilTabBarView() {
    _router?.popUntil(
      (element) =>
          element.settings is! AutoRoutePage ||
          (element.settings as AutoRoutePage)
              .routeData
              .topMatch
              .toPageRouteInfo()
              .isTabView,
    );
  }

  void refreshState() {
    // async func is used to make sure the state is updated after the next frame
    Future.microtask(() {
      print("last: rebuildd");
      state = build();
    });
  }

  @override
  NavigationState build() {
    final s = _stack.lastWhereOrNull((element) => element.isTabView);
    print("last: $s");
    return (
      isStackPoppable: _stack.length > 1,
      activeTab:
          _stack.lastWhereOrNull((element) => element.isTabView)?.tabBarEnum ??
              NavBarEnum.home,
    );
  }
}

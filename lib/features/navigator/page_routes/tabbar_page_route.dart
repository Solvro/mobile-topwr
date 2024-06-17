import 'package:flutter/material.dart';

import '../../../config/nav_bar_config.dart';
import '../../../config/tabs.dart';
import 'detail_page_route.dart';

class TabBarPageRoute extends MaterialPageRoute {
  TabBarPageRoute({
    required this.previousTab,
    required this.newTab,
  }) : super(
          builder: (context) {
            return TabsConfig.tabs.get(newTab);
          },
          settings: RouteSettings(
            name: AppRoutes.root,
            arguments: newTab,
          ),
          maintainState:
              false, // to avoid trashing RAM when changing tabs multiple times
        );

  final NavBarEnum previousTab;
  final NavBarEnum newTab;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final isNewTabMoreToRight = newTab.index >= previousTab.index;

    final animationTween = Tween(
      begin: isNewTabMoreToRight
          ? const Offset(1.0, 0.0) // slide from right
          : const Offset(-1.0, 0.0), // slide from left
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.ease));

    return SlideTransition(
      position: animation.drive(animationTween),
      child: child,
    );
  }
}

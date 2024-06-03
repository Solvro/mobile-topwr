import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../bottom_nav_bar/nav_bar_config.dart';
import '../../buildings_map/buildings_view.dart';
import '../../departments_tab/departments_tab.dart';
import '../../home_view/home_view.dart';
import '../../iparking/parking_view.dart';
import '../../student_research_group_tab/scientific_circles_tab.dart';
import 'detail_page_route.dart';

class TabBarPageRoute extends MaterialPageRoute {
  static const _widgetOptions = UnmodifiableNavBarEnumMap(
    home: HomeView(),
    mapp: BuildingMapView(),
    faculties: DepartmentTab(),
    sciCircles: ScientificCirclesTab(),
    parkings: ParkingsMapView(),
    info: _InfoPlaceholder(),
  );

  TabBarPageRoute({
    required this.previousTab,
    required this.newTab,
  }) : super(
          builder: (context) {
            return _widgetOptions.get(newTab);
          },
          settings: RouteSettings(
            name: AppRoutes.root,
            arguments: newTab,
          ),
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

class _InfoPlaceholder extends StatelessWidget {
  const _InfoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorTheme.whiteSoap,
      child: const Center(
        child: Text("Info"),
      ),
    );
  }
}

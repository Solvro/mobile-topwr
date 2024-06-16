import 'package:flutter/material.dart';

import '../../../config/nav_bar_config.dart';
import '../../cooming_soon.dart';
import 'detail_page_route.dart';

class TabBarPageRoute extends MaterialPageRoute {
  static const _widgetOptions = UnmodifiableNavBarEnumMap(
    home: CoomingSoon(),
    mapp: CoomingSoon(),
    faculties: CoomingSoon(),
    sciCircles: CoomingSoon(),
    parkings: CoomingSoon(),
    info: CoomingSoon(),
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
          maintainState:
              false, // to avoid trashing RAM when changing tabs multiple times
        );

  final NavBarEnum previousTab;
  final NavBarEnum newTab;
}

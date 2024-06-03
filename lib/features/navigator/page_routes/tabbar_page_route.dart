import 'package:flutter/material.dart';

import '../../bottom_nav_bar/nav_bar_config.dart';
import '../../buildings_map/buildings_view.dart';
import '../../departments_tab/departments_tab.dart';
import '../../home_view/home_view.dart';
import '../../iparking/parking_view.dart';
import '../../student_research_group_tab/scientific_circles_tab.dart';

class TabbarPageRoute extends MaterialPageRoute {
  static const _widgetOptions = UnmodifiableNavBarEnumMap(
    home: HomeView(),
    mapp: BuildingMapView(),
    faculties: DepartmentTab(),
    sciCircles: ScientificCirclesTab(),
    parkings: ParkingsMapView(),
    info: Center(
      child: Text("Info"),
    ),
  );

  TabbarPageRoute(NavBarEnum? tab, {super.settings})
      : super(
          builder: (context) {
            return _widgetOptions.get(tab ?? NavBarEnum.home);
          },
        );
}

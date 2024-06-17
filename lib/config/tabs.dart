import 'package:flutter/material.dart';

import '../features/buildings_map/buildings_view.dart';
import '../features/departments_tab/departments_tab.dart';
import '../features/home_view/home_view.dart';
import '../features/iparking/parking_view.dart';
import '../features/student_research_group_tab/scientific_circles_tab.dart';
import '../theme/app_theme.dart';
import 'nav_bar_config.dart';

abstract class TabsConfig {
  static const tabs = UnmodifiableNavBarEnumMap(
    home: HomeView(),
    mapp: BuildingMapView(),
    faculties: DepartmentTab(),
    sciCircles: ScientificCirclesTab(),
    parkings: ParkingsMapView(),
    info: _InfoPlaceholder(),
  );
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

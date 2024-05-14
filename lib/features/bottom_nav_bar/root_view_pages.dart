import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../buildings_map/buildings_view.dart';
import '../departments_tab/departments_tab.dart';
import '../home_view/home_view.dart';
import '../iparking/parking_view.dart';
import '../student_research_group_tab/scientific_circles_tab.dart';
import 'bottom_nav_bar_controller.dart';
import 'nav_bar_config.dart';

class RootViewPages extends ConsumerWidget {
  const RootViewPages({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(bottomNavBarControllerProvider);
    return _widgetOptions.get(selectedTab);
  }
}

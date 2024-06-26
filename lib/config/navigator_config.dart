import '../features/buildings_map/buildings_view.dart';
import '../features/departments_tab/departments_tab.dart';
import '../features/guide/guide_view_template.dart';
import '../features/home_view/home_view.dart';
import '../features/iparking/parking_view.dart';
import '../features/student_research_group_tab/scientific_circles_tab.dart';
import 'nav_bar_config.dart';

abstract class NavigatorConfig {
  static const initialTab = NavBarEnum.home;
}


abstract class TabsConfig {
  static const tabs = UnmodifiableNavBarEnumMap(
    home: HomeView(),
    mapp: BuildingMapView(),
    faculties: DepartmentTab(),
    sciCircles: ScientificCirclesTab(),
    parkings: ParkingsMapView(),
    info: GuideViewTemplate(),
  );
}

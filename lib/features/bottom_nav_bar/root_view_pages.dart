import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../departments_tab/departments_tab.dart';
import '../home_view/home_view.dart';
import '../iparking/parking_view.dart';
import '../map_view/map_view.dart';
import 'bottom_nav_bar_controller.dart';
import 'nav_bar_config.dart';

class RootViewPages extends ConsumerWidget {
  /// displays proper selected tab view (selected in bottom tab nav bar)
  const RootViewPages({super.key});

  static const _widgetOptions = UnmodifiableNavBarEnumMap(
    home: HomeView(),
    mapp: MapView(),
    faculties: DepartmentTab(),
    sciCircles: _PlaceholderView("sciCircles"),
    info: ParkingView(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(bottomNavBarControllerProvider);
    return _widgetOptions.get(selectedTab);
  }
}

class _PlaceholderView extends StatelessWidget {
  /// Placeholder view created to test navigation between pages
  const _PlaceholderView(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(text),
    ));
  }
}

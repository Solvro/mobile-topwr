import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../map_view/controllers/bottom_sheet_controller.dart';
import '../map_view/controllers/controllers_set.dart';
import '../map_view/map_view.dart';
import 'controllers.dart';

class BuildingMapView extends ConsumerWidget {
  const BuildingMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
        overrides: [
          mapControllersProvider.overrideWith((ref) => mapControllersBuildings),
          bottomSheetControllerProvider,
          bottomSheetPixelsProvider,
        ],
        child: GeneralMapView(
          mapControllers: mapControllersBuildings,
        ));
  }
}

class ParkingsMapView extends ConsumerWidget {
  const ParkingsMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
        overrides: [
          mapControllersProvider.overrideWith((ref) => mapControllersBuildings),
          bottomSheetControllerProvider,
          bottomSheetPixelsProvider,
        ],
        child: GeneralMapView(
          mapControllers: mapControllersBuildings,
        ));
  }
}

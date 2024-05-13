import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared_repositories/buildings_repository/building_extra_params_ext.dart';
import '../../shared_repositories/buildings_repository/map_buildings_repo.dart';
import '../map_view/controllers/bottom_sheet_controller.dart';
import '../map_view/map_view.dart';
import 'controllers.dart';

class BuildingMapView extends ConsumerWidget {
  const BuildingMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
        overrides: [
          bottomSheetControllerProvider,
          bottomSheetPixelsProvider,
        ],
        child: GeneralMapView<Building>(
          mapControllers: mapControllersBuildings,
          markerBuilder: (item, ref) => Marker(
            consumeTapEvents: true,
            markerId: item.markerId,
            position: item.location,
            icon: ref.watchMapIcon(item),
            onTap: () {
              item.onMarkerTap(item);
            },
          ),
        ));
  }
}

class ParkingsMapView extends ConsumerWidget {
  const ParkingsMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
        overrides: [
          bottomSheetControllerProvider,
          bottomSheetPixelsProvider,
        ],
        child: GeneralMapView<Building>(
          mapControllers: mapControllersBuildings,
          markerBuilder: (item, ref) => Marker(
            consumeTapEvents: true,
            markerId: item.markerId,
            position: item.location,
            icon: ref.watchMapIcon(item),
            onTap: () {
              item.onMarkerTap(item);
            },
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared_repositories/buildings_repository/building_extra_params_ext.dart';
import '../../shared_repositories/buildings_repository/map_buildings_repo.dart';
import '../../utils/context_extensions.dart';
import '../map_view/map_view.dart';
import '../map_view/utils/map_marker_utils.dart';
import 'building_tile.dart';
import 'controllers.dart';

class BuildingMapView extends ConsumerWidget {
  const BuildingMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GeneralMapView<Building>(
      mapViewTexts: (
        emptyList: context.localize.building_not_found,
        title: context.localize.buildings_title,
      ),
      mapControllers: mapControllersBuildings,
      mapTileBuilder: (item, isActive) => BuildingTile(item, isActive),
      markerBuilder: (item, ref, isActive) => Marker(
        consumeTapEvents: true,
        markerId: item.markerId,
        position: item.location,
        icon: isActive
            ? MapMarkerUtils.activeMapMarker
            : MapMarkerUtils.mapMarker,
        onTap: () {
          ref.read(buildingsMapControllerProvider.notifier).onMarkerTap(item);
        },
      ),
    );
  }
}

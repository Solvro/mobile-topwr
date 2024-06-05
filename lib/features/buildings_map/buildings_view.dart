import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config/map_view_config.dart';
import '../../shared_repositories/buildings_repository/building_model.dart';
import '../../utils/context_extensions.dart';
import '../map_view/map_view.dart';
import '../map_view/utils/map_marker_utils.dart';
import 'building_tile.dart';
import 'controllers.dart';

class BuildingMapView extends ConsumerWidget {
  const BuildingMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GeneralMapView<BuildingModel>(
      mapViewTexts: (
        emptyList: context.localize.building_not_found,
        title: context.localize.buildings_title,
      ),
      mapSheetSize: MapViewBottomSheetConfig.buildingsMapSheetSize,
      mapControllers: mapControllersBuildings,
      mapTileBuilder: BuildingTile.new,
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

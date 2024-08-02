import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

import "../../config/map_view_config.dart";
import "../../utils/context_extensions.dart";
import "../map_view/map_view.dart";
import "../map_view/utils/map_marker_utils.dart";
import "building_tile.dart";
import "controllers.dart";
import "model/building_model.dart";

@RoutePage()
class BuildingsView extends ConsumerWidget {
  const BuildingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MapView<BuildingModel>(
      mapViewTexts: (
        emptyList: context.localize.building_not_found,
        title: context.localize.buildings_title,
      ),
      mapSheetSize: MapViewBottomSheetConfig.buildingsMapSheetSize,
      mapControllers: mapControllersBuildings,
      mapTileBuilder: BuildingTile.new,
      markerBuilder: (item, ref, {required isActive}) => Marker(
        consumeTapEvents: true,
        markerId: item.markerId,
        position: item.location,
        icon: isActive
            ? MapMarkerUtils.activeBuildingMapMarker
            : MapMarkerUtils.buildingMapMarker,
        onTap: () {
          ref.read(buildingsMapControllerProvider.notifier).onMarkerTap(item);
        },
      ),
    );
  }
}

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

import "../../config/map_view_config.dart";
import "../../utils/context_extensions.dart";
import "../map_view/map_view.dart";
import "../map_view/utils/map_marker_utils.dart";
import "controllers.dart";
import "models/parking.dart";
import "widgets/parking_tile.dart";

@RoutePage()
class ParkingsView extends ConsumerWidget {
  const ParkingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MapView<Parking>(
      mapViewTexts: (
        emptyList: context.localize.parkings_not_found,
        title: context.localize.parkings_title,
      ),
      animateListTiles: true,
      mapSheetSize: MapViewBottomSheetConfig.parkingsMapSheetSize,
      mapControllers: parkingsMapControllers,
      mapTileBuilder: ParkingTile.new,
      markerBuilder: (item, ref, {required bool isActive}) => Marker(
        consumeTapEvents: true,
        markerId: MarkerId(item.id),
        position: item.location,
        icon: isActive
            ? MapMarkerUtils.activeParkingMapMarker
            : MapMarkerUtils.parkingMapMarker,
        onTap: () {
          ref.read(parkingsMapControllerProvider.notifier).onMarkerTap(item);
        },
      ),
    );
  }
}

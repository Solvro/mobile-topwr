import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/map_view_config.dart";
import "../../gen/assets.gen.dart";
import "../../utils/context_extensions.dart";
import "../map_view/map_view.dart";
import "controllers.dart";
import "models/parking.dart";
import "widgets/parking_tile.dart";

@RoutePage()
class ParkingsView extends ConsumerWidget {
  const ParkingsView({
    super.key,
    @PathParam("initialActiveItemId") this.initialActiveItemId,
  });
  final String? initialActiveItemId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MapView<Parking>(
      mapViewTexts: (
        emptyList: context.localize.parkings_not_found,
        title: context.localize.parkings_title,
      ),
      initialActiveItemId: initialActiveItemId,
      animateListTiles: true,
      mapSheetSize: MapViewBottomSheetConfig.parkingsMapSheetSize,
      mapControllers: parkingsMapControllers,
      mapTileBuilder: ParkingTile.new,
      markerBuilder: (item, ref, {required bool isActive}) => Marker(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            unawaited(
              ref.read(parkingsMapControllerProvider).onMarkerTap(item),
            );
          },
          child: Image.asset(
            isActive
                ? Assets.png.mapMarkers.activeParkingMapMarker.path
                : Assets.png.mapMarkers.parkingMapMarker.path,
          ),
        ),
        point: item.location,
      ),
    );
  }
}

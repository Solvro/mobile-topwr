import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config.dart';
import '../../utils/context_extensions.dart';
import '../map_view/map_view.dart';
import '../map_view/utils/map_marker_utils.dart';
import 'controllers.dart';
import 'models/parking_model.dart';
import 'widgets/parking_tile.dart';

class ParkingsMapView extends ConsumerWidget {
  const ParkingsMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GeneralMapView<ParkingPlace>(
      mapViewTexts: (
        emptyList: context.localize.parkings_not_found,
        title: context.localize.parkings_title,
      ),
      mapSheetSize: MapViewBottomSheetConfig.parkingsMapSheetSize,
      mapControllers: parkingsMapControllers,
      mapTileBuilder: (item, isActive) => ParkingTile(item, isActive),
      markerBuilder: (item, ref, isActive) => Marker(
        consumeTapEvents: true,
        markerId: MarkerId(item.id),
        position: item.location,
        icon: isActive
            ? MapMarkerUtils.activeMapMarker
            : MapMarkerUtils.mapMarker,
        onTap: () {
          ref.read(parkingsMapControllerProvider.notifier).onMarkerTap(item);
        },
      ),
    );
  }
}

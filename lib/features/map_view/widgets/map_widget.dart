import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../controllers/map_chosen_pin_contrl.dart';
import '../controllers/map_view_controller.dart';
import '../controllers/map_widget_controller.dart';

class MapWidget extends ConsumerWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildings = ref.watch(mapViewControllerProvider).value.whereNonNull;
    return GoogleMap(
        mapType: MapWidgetConfig.mapType,
        initialCameraPosition: MapWidgetConfig.defaultCameraPosition,
        onMapCreated: (GoogleMapController contrl) =>
            ref.read(mapWidgetControllerProvider.notifier).onMapCreated(contrl),
        markers: {
          for (var building in buildings)
            Marker(
              markerId: MarkerId(building.id),
              position: LatLng(building.latitude, building.longitude),
              icon: building == ref.watch(mapChosenPinControllerProvider)
                  ? MapWidgetController.activeMapMarker
                  : MapWidgetController.mapMarker,
            ),
        });
  }
}

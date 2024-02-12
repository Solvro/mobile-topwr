import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../controllers/map_chosen_pin_contrl.dart';
import '../controllers/map_widget_controller.dart';
import '../repository/map_buildings_repo.dart';

class MapWidget extends ConsumerWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingsState =
        ref.watch(mapBuildingsRepositoryProvider).value.whereNonNull;

    final mapController = ref.watch(mapWidgetControllerProvider.notifier);

    final chosenPinController =
        ref.watch(mapChosenPinControllerProvider.notifier);

    return GoogleMap(
        mapType: MapWidgetConfig.mapType,
        initialCameraPosition: MapWidgetConfig.defaultCameraPosition,
        onMapCreated: mapController.onMapCreated,
        onTap: (_) => chosenPinController.unselect(),
        markers: {
          for (var building in buildingsState)
            Marker(
              markerId: MarkerId(building.id),
              position: LatLng(building.latitude, building.longitude),
              icon: building == ref.watch(mapChosenPinControllerProvider)
                  ? MapWidgetController.activeMapMarker
                  : MapWidgetController.mapMarker,
              onTap: () => chosenPinController.toggleBuilding(building),
            ),
        });
  }
}

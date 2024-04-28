import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config.dart';
import '../../../shared_repositories/buildings_repository/building_extra_params_ext.dart';
import '../../../shared_repositories/buildings_repository/map_buildings_repo.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../controllers/bottom_sheet_controller.dart';
import '../controllers/map_controller.dart';

class MapWidget extends ConsumerWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingsState =
        ref.watch(mapBuildingsRepositoryProvider).value.whereNonNull;

    final mapController = ref.watch(mapControllerProvider.notifier);

    return GoogleMap(
      mapType: MapWidgetConfig.mapType,
      initialCameraPosition: MapWidgetConfig.defaultCameraPosition,
      onMapCreated: mapController.onMapCreated,
      onTap: mapController.onMapBgTap,
      markers: {
        for (var building in buildingsState)
          Marker(
            consumeTapEvents: true,
            markerId: building.markerId,
            position: building.location,
            icon: ref.watchMapIcon(building),
            onTap: () {
              mapController.onMarkerTap(building);
            },
          ),
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      compassEnabled: true,
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top,
        bottom: ref.watch(bottomSheetPixelsProvider),
      ),
    );
  }
}

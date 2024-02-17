import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../controllers/bottom_sheet_controller.dart';
import '../controllers/map_controller.dart';
import '../repository/building_extra_params_ext.dart';
import '../repository/map_buildings_repo.dart';

class MapWidget extends ConsumerWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingsState =
        ref.watch(mapBuildingsRepositoryProvider).value.whereNonNull;

    final mapController = ref.watch(mapControllerProvider.notifier);

    final c = createLocalImageConfiguration(context);
    print(c.devicePixelRatio);

    return GoogleMap(
      mapType: MapWidgetConfig.mapType,
      initialCameraPosition: MapWidgetConfig.defaultCameraPosition,
      onMapCreated: mapController.onMapCreated,
      onTap: (_) {
        context.unfocus();
        mapController.onMapBgTap();
      },
      markers: {
        for (var building in buildingsState)
          Marker(
            consumeTapEvents: true,
            markerId: building.markerId,
            position: building.location,
            icon: ref.watchMapIcon(building),
            onTap: () {
              context.unfocus();
              mapController.onMarkerTap(building);
            },
          ),
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapToolbarEnabled: false,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      compassEnabled: true,
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top,
        bottom: ref.watch(bottomSheetPixelsProvider),
      ),
    );
  }
}

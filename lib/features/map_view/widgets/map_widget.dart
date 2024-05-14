import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../controllers/bottom_sheet_controller.dart';
import 'map_config.dart';

class MapWidget<T> extends ConsumerWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState =
        ref.watch(context.mapSourceRepository<T>()).value.whereNonNull;

    final mapController = ref.watch(
      context.mapController<T>().notifier,
    );

    final activeItem = ref.watch(context.activeMarkerController<T>());

    return GoogleMap(
      mapType: MapWidgetConfig.mapType,
      initialCameraPosition: MapWidgetConfig.defaultCameraPosition,
      onMapCreated: mapController.onMapCreated,
      onTap: mapController.onMapBgTap,
      markers: itemsState
          .map((item) => context.markerBuilder<T>()(
                item,
                ref,
                activeItem == item,
              ))
          .toSet(),
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

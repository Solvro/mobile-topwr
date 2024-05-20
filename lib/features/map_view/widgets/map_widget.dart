import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/my_error_widget.dart';
import '../controllers/bottom_sheet_controller.dart';
import '../controllers/controllers_set.dart';
import 'map_config.dart';
import '../utils/location_permission_status_provider.dart';

class MapWidget<T extends GoogleNavigable> extends ConsumerWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState =
        ref.watch(context.mapSourceRepository<T>()).value.whereNonNull;

    final mapController = ref.watch(
      context.mapController<T>().notifier,
    );

    final activeItem = ref.watch(context.activeMarkerController<T>());
    return ref.watch(locationPermissionStatusProvider).when(
        data: (isGranted) {
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
      myLocationEnabled: isGranted,
      myLocationButtonEnabled: isGranted,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      compassEnabled: true,
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top,
        bottom: ref.watch(bottomSheetPixelsProvider),
      ),
    );
  },
    loading: () => const SizedBox(),
    error: (error,_) => MyErrorWidget(error),
    );
}

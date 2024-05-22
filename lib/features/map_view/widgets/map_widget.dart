import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/my_error_widget.dart';
import '../controllers/bottom_sheet_controller.dart';
import '../controllers/controllers_set.dart';
import '../utils/location_permission_status_provider.dart';
import 'map_config.dart';

class MapWidget<T extends GoogleNavigable> extends ConsumerWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(context.mapSourceRepository<T>());
    return switch (asyncItems) {
      AsyncLoading() => _MapWidget<T>(const []),
      AsyncError() => _MapWidget<T>(const []),
      AsyncValue(:final value) => _MapWidget<T>(value.whereNonNull.toList()),
    };
  }
}

class _MapWidget<T extends GoogleNavigable> extends ConsumerWidget {
  const _MapWidget(this.items);

  final List<T> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = ref.watch(
      context.mapController<T>().notifier,
    );

    final activeItem = ref.watch(context.activeMarkerController<T>());

    final locationStatus = ref.watch(locationPermissionStatusProvider);
    return switch (locationStatus) {
      AsyncLoading() => const SizedBox(),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => GoogleMap(
          mapType: MapWidgetConfig.mapType,
          initialCameraPosition: MapWidgetConfig.defaultCameraPosition,
          onMapCreated: mapController.onMapCreated,
          onTap: mapController.onMapBgTap,
          markers: items
              .map((item) => context.markerBuilder<T>()(
                    item,
                    ref,
                    activeItem == item,
                  ))
              .toSet(),
          myLocationEnabled: value ?? false,
          myLocationButtonEnabled: value ?? false,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          compassEnabled: true,
          padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top,
            bottom: ref.watch(bottomSheetPixelsProvider),
          ),
        ),
    };
  }
}

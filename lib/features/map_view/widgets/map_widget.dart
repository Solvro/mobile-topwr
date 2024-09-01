import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

import "../../../config/map_view_config.dart";
import "../../../utils/where_non_null_iterable.dart";
import "../../../widgets/my_error_widget.dart";
import "../controllers/bottom_sheet_controller.dart";
import "../controllers/controllers_set.dart";
import "../utils/location_permission_status_provider.dart";
import "map_config.dart";

class MapWidget<T extends GoogleNavigable> extends ConsumerWidget {
  const MapWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = ref.watch(
      context.mapController<T>().notifier,
    );

    final activeItem = ref.watch(context.activeMarkerController<T>());

    final locationStatus = ref.watch(locationPermissionStatusProvider);

    return switch (locationStatus) {
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final asyncItems = ref
                .watch(context.mapSourceRepository<T>())
                .value
                .whereNonNull
                .toList();
            return GoogleMap(
              initialCameraPosition: MapWidgetConfig.defaultCameraPosition,
              onMapCreated: mapController.onMapCreated,
              onTap: mapController.onMapBackgroundTap,
              markers: asyncItems
                  .map(
                    (item) => context.markerBuilder<T>()(
                      item,
                      ref,
                      isActive: activeItem == item,
                    ),
                  )
                  .toSet(),
              myLocationEnabled: value ?? false,
              myLocationButtonEnabled: value ?? false,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top,
                bottom: ref.watch(bottomSheetPixelsProvider),
              ),
            );
          },
        ),
    };
  }
}

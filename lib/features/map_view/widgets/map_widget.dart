import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/my_error_widget.dart';
import '../controllers/bottom_sheet_controller.dart';
import '../controllers/controllers_set.dart';
import 'map_config.dart';

class MapWidget<T extends GoogleNavigable> extends ConsumerWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(context.mapSourceRepository<T>());
    return switch (asyncItems) {
      AsyncLoading() => const CircularProgressIndicator(),
      AsyncError(error: final DioException _) => _MapWidget<T>(const []),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => _MapWidget<T>(value.whereNonNull.toList()),
    };
  }
}

class _MapWidget<T extends GoogleNavigable> extends ConsumerWidget {
  const _MapWidget(this.value);

  final List<T> value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = ref.watch(
      context.mapController<T>().notifier,
    );

    final activeItem = ref.watch(context.activeMarkerController<T>());

    return GoogleMap(
      mapType: MapWidgetConfig.mapType,
      initialCameraPosition: MapWidgetConfig.defaultCameraPosition,
      onMapCreated: mapController.onMapCreated,
      onTap: mapController.onMapBgTap,
      markers: value.whereNonNull
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

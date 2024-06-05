import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/map_view_config.dart';
import 'bottom_sheet_controller.dart';
import 'controllers_set.dart';

mixin MapController<T extends GoogleNavigable>
    on AutoDisposeNotifier<GoogleMapController?> {
  late final MapControllers<T> mapControllers;

  static Future<void> initializeGoogleMapsRenderingAndroid() async {
    final GoogleMapsFlutterPlatform mapsImpl =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImpl is GoogleMapsFlutterAndroid) {
      mapsImpl.useAndroidViewSurface = true;
      await mapsImpl.initializeWithRenderer(AndroidMapRenderer.latest);
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    ref.invalidate(bottomSheetPixelsProvider);
    state = controller;
    final activeMarker = ref.read(mapControllers.activeMarker);
    if (activeMarker != null) zoomOnMarker(activeMarker);
  }

  void zoomOnMarker(T item) {
    Future.delayed(
      Durations.short1,
      () => state?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: item.location,
            zoom: MapWidgetConfig.defaultMarkerZoom,
          ),
        ),
      ),
    );
  }

  void onMarkerTap(T item) {
    ref.read(mapControllers.activeMarker.notifier).toggleBuilding(item);
    ref.read(bottomSheetControllerProvider).resetSafe();
    if (ref.read(mapControllers.activeMarker) == item) {
      zoomOnMarker(item);
    }
  }

  void onMapBackgroundTap(_) {
    ref.read(mapControllers.activeMarker.notifier).unselect();
    ref.read(bottomSheetControllerProvider).resetSafe();
  }
}

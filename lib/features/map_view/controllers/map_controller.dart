import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config.dart';
import '../../../shared_repositories/buildings_repository/building_extra_params_ext.dart';
import '../../../shared_repositories/buildings_repository/map_buildings_repo.dart';
import 'active_map_marker_cntrl.dart';
import 'bottom_sheet_controller.dart';

part "map_controller.g.dart";

@riverpod
class MapController extends _$MapController {
  static Future<void> initializeGoogleMapsRenderingAndroid() async {
    final GoogleMapsFlutterPlatform mapsImpl =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImpl is GoogleMapsFlutterAndroid) {
      mapsImpl.useAndroidViewSurface = true;
      await mapsImpl.initializeWithRenderer(AndroidMapRenderer.latest);
    }
  }

  @override
  GoogleMapController? build() {
    return null;
  }

  void onMapCreated(GoogleMapController controller) async {
    ref.invalidate(bottomSheetPixelsProvider);
    state = controller;
    final activeMarker = ref.read(activeMapMarkerControllerProvider);
    if (activeMarker != null) zoomOnMarker(activeMarker);
  }

  void zoomOnMarker(Building building) {
    Future.delayed(
      Durations.short1,
      () => state?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: building.location,
            zoom: MapWidgetConfig.defaultMarkerZoom,
          ),
        ),
      ),
    );
  }

  void onMarkerTap(Building building) {
    ref
        .read(activeMapMarkerControllerProvider.notifier)
        .toggleBuilding(building);
    ref.read(bottomSheetControllerProvider).resetSafe();
    if (ref.read(activeMapMarkerControllerProvider) == building) {
      zoomOnMarker(building);
    }
  }

  void onMapBgTap(_) {
    ref.read(activeMapMarkerControllerProvider.notifier).unselect();
    ref.read(bottomSheetControllerProvider).resetSafe();
  }
}

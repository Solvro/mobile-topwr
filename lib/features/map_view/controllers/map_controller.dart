import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config.dart';
import '../repository/building_extra_params_ext.dart';
import '../repository/map_buildings_repo.dart';
import 'active_map_marker_cntrl.dart';
import 'bottom_sheet_controller.dart';

part "map_controller.g.dart";

@riverpod
class MapController extends _$MapController {
  static late final BitmapDescriptor mapMarker;
  static late final BitmapDescriptor activeMapMarker;

  static Future<void> loadMapMarkerAssets() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      MapWidgetConfig.mapMarkerAssetName,
    );
    activeMapMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      MapWidgetConfig.activeMapMarkerAssetName,
    );
  }

  static Future<void> initializeGoogleMapsRenderingAndroid() async {
    final GoogleMapsFlutterPlatform mapsImpl =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImpl is GoogleMapsFlutterAndroid) {
      mapsImpl.useAndroidViewSurface = true;
      await mapsImpl.initializeWithRenderer(AndroidMapRenderer.latest);
    }
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Future<GoogleMapController> build() async {
    return await _controller.future;
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void zoomOnMarker(Building building) {
    state.value?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: building.location,
          zoom: MapWidgetConfig.defaultMarkerZoom,
        ),
      ),
    );
  }

  void onMarkerTap(Building building) {
    ref
        .read(activeMapMarkerControllerProvider.notifier)
        .toggleBuilding(building);
    if (ref.read(activeMapMarkerControllerProvider) == building) {
      zoomOnMarker(building);
    }
    ref.read(bottomSheetControllerProvider).reset();
  }

  void onMapBgTap() {
    ref.read(activeMapMarkerControllerProvider.notifier).unselect();
    ref.read(bottomSheetControllerProvider).reset();
  }
}

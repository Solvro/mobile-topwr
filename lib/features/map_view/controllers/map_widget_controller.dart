import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config.dart';
import '../repository/building_extra_params_ext.dart';
import '../repository/map_buildings_repo.dart';
import 'map_active_marker_cntrl.dart';
import 'map_view_controller.dart';

part "map_widget_controller.g.dart";

@riverpod
class MapWidgetController extends _$MapWidgetController {
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
    state.value?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: building.location,
      zoom: MapWidgetConfig.defaultMarkerZoom,
    )));
  }

  void onMarkerTap(Building building) {
    ref
        .read(mapActiveMarkerControllerProvider.notifier)
        .toggleBuilding(building);
    if (building.isActive(ref.read)) {
      zoomOnMarker(building);
    }
    ref.watch(bottomSheetControllerProvider).reset();
  }

  void onMapBgTap(LatLng _) {
    ref.read(mapActiveMarkerControllerProvider.notifier).unselect();
    ref.read(bottomSheetControllerProvider).reset();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/active_map_marker_cntrl.dart';
import '../utils/map_marker_utils.dart';
import 'map_buildings_repo.dart';

extension BuildingExtraParamsExt on Building {
  LatLng get location => LatLng(latitude, longitude);

  MarkerId get markerId => MarkerId(id);

  String? get addresFormatted =>
      addres?.replaceFirst(",", "\n").replaceAll("\n ", "\n");

  BitmapDescriptor getMapMarker(bool isActive) =>
      isActive ? MapMarkerUtils.activeMapMarker : MapMarkerUtils.mapMarker;
}

extension IsBuildingActive on WidgetRef {
  bool watchIsActive(Building building) =>
      watch(activeMapMarkerControllerProvider) == building;

  bool readIsActive(Building building) =>
      read(activeMapMarkerControllerProvider) == building;

  BitmapDescriptor watchMapIcon(Building building) =>
      building.getMapMarker(watchIsActive(building));

  BitmapDescriptor readMapIcon(Building building) =>
      building.getMapMarker(readIsActive(building));
}

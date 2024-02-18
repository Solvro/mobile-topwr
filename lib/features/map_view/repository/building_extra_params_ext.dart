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
}

extension IsBuildingActiveExt on WidgetRef {
  bool watchIsActive(Building building) =>
      watch(activeMapMarkerControllerProvider) == building;

  BitmapDescriptor watchMapIcon(Building building) => watchIsActive(building)
      ? MapMarkerUtils.activeMapMarker
      : MapMarkerUtils.mapMarker;
}

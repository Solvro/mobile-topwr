import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../features/buildings_map/controllers.dart';
import '../../features/map_view/utils/map_marker_utils.dart';
import 'map_buildings_repo.dart';

extension BuildingExtraParamsExt on Building {
  LatLng get location => LatLng(latitude, longitude);

  MarkerId get markerId => MarkerId(id);

  String? get addresFormatted =>
      addres?.replaceFirst(",", "\n").replaceAll("\n ", "\n");
}

extension IsBuildingActiveExt on WidgetRef {
  bool watchIsActive(Building building) =>
      watch(activeBuildingControllerProvider) == building;

  BitmapDescriptor watchMapIcon(Building building) => watchIsActive(building)
      ? MapMarkerUtils.activeMapMarker
      : MapMarkerUtils.mapMarker;
}

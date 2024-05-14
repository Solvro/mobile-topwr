import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_buildings_repo.dart';

extension BuildingExtraParamsExt on Building {
  LatLng get location => LatLng(latitude, longitude);

  MarkerId get markerId => MarkerId(id);

  String? get addresFormatted =>
      addres?.replaceFirst(",", "\n").replaceAll("\n ", "\n");
}

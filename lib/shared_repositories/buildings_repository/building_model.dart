import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../features/iparking/models/parking_model.dart';
import 'map_buildings_repo.dart';

class BuildingModel extends Building implements GoogleNavigable {
  BuildingModel.from(Building building)
      : super(
          id: building.id,
          code: building.code,
          name: building.name,
          longitude: building.longitude,
          latitude: building.latitude,
          addres: building.addres,
          photo: building.photo,
        );

  @override
  LatLng get location => LatLng(latitude, longitude);

  MarkerId get markerId => MarkerId(id);

  String? get addresFormatted =>
      addres?.replaceFirst(",", "\n").replaceAll("\n ", "\n");
}

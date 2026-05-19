import "package:flutter_map_location_marker/flutter_map_location_marker.dart";
import "package:latlong2/latlong.dart";

extension LatLngValidity on LatLng {
  bool get isValidForMap =>
      latitude.isFinite &&
      longitude.isFinite &&
      latitude >= -90 &&
      latitude <= 90 &&
      longitude >= -180 &&
      longitude <= 180;
}

extension LocationMarkerPositionValidity on LocationMarkerPosition {
  bool get isValidForMap => latLng.isValidForMap;
}

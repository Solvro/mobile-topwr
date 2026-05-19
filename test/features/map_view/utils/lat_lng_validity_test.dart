import "package:flutter_test/flutter_test.dart";
import "package:latlong2/latlong.dart";
import "package:topwr/features/map_view/utils/lat_lng_validity.dart";

void main() {
  group("LatLng.isValidForMap", () {
    test("accepts Wrocław campus coordinates", () {
      expect(const LatLng(51.10738, 17.05964).isValidForMap, isTrue);
    });

    test("rejects NaN coordinates", () {
      expect(const LatLng(double.nan, 17).isValidForMap, isFalse);
      expect(const LatLng(51, double.nan).isValidForMap, isFalse);
    });

    test("rejects infinite coordinates", () {
      expect(const LatLng(double.infinity, 17).isValidForMap, isFalse);
      expect(const LatLng(51, double.negativeInfinity).isValidForMap, isFalse);
    });

    test("rejects out-of-range coordinates", () {
      expect(const LatLng(91, 0).isValidForMap, isFalse);
      expect(const LatLng(0, 181).isValidForMap, isFalse);
    });
  });
}

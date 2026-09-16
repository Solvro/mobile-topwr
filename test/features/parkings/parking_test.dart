import "package:test/test.dart";
import "package:topwr/features/parkings/parkings_view/models/parking.dart";

void main() {
  test("defaults missing parking access to all", () {
    expect(Parking.fromJson(_parkingJson()).access, ParkingAccess.all);
  });

  test("defaults null parking access to all", () {
    expect(Parking.fromJson({..._parkingJson(), "access": null}).access, ParkingAccess.all);
  });
}

Map<String, dynamic> _parkingJson() => {
  "id": "1",
  "parking_id": "1",
  "liczba_miejsc": "10",
  "symbol": "A",
  "type": null,
  "nazwa": "Main",
  "open_hour": null,
  "close_hour": null,
  "places": "10",
  "geo_lan": "17.03",
  "geo_lat": "51.11",
  "photo": "",
  "miniature": null,
  "aktywny": "1",
  "show_park": "1",
  "lp": "1",
  "address": "",
  "trend": "0",
};

import "package:flutter/material.dart";
import "package:topwr/features/parkings/parkings_view/models/parking.dart";
import "package:topwr/features/parkings/parkings_view/widgets/parking_wide_tile_card.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _productionParking = Parking(
  id: "2",
  parkingId: "2",
  numberOfPlaces: "55",
  symbol: "C13",
  type: "O",
  name: "Polinka",
  openHour: "00:00:00",
  closeHour: "00:00:00",
  places: "54",
  geoLan: "17.06094",
  geoLat: "51.10804",
  photo: "https://parking-api.topwr.solvro.pl/images/parkings/original/C13.jpg",
  miniaturePhoto: "https://parking-api.topwr.solvro.pl/images/parkings/miniatures/C13.jpg",
  active: "1",
  showPark: "1",
  lp: "",
  address: "wybrzeże Stanisława Wyspiańskiego 25",
  trend: "0",
  access: ParkingAccess.students,
);

@widgetbook.UseCase(name: "default", type: ParkingWideTileCard)
Widget useCaseParkingWideTileCard(BuildContext context) {
  return const ParkingWideTileCard(parking: _productionParking, isActive: true);
}

import "package:flutter/material.dart";
import "package:topwr/features/parkings/parkings_view/models/parking.dart";
import "package:topwr/features/parkings/parkings_view/widgets/parking_wide_tile_card.dart";
import "package:widgetbook/widgetbook.dart";

part "parking_wide_tile_card.stories.g.dart";

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
  photo: "",
  miniaturePhoto: "",
  active: "1",
  showPark: "1",
  lp: "",
  address: "wybrzeże Stanisława Wyspiańskiego 25",
  trend: "0",
  access: ParkingAccess.students,
);

const meta = Meta<ParkingWideTileCard>();

final $default = ParkingWideTileCardStory(args: ParkingWideTileCardArgs(parking: Arg.fixed(_productionParking)));

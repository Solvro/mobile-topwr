import "package:flutter/material.dart";
import "package:topwr/features/parkings/parking_chart/parking_chart.dart";
import "package:topwr/features/parkings/parkings_view/models/parking.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../widgetbook_placeholders.dart";

part "parking_chart.stories.g.dart";

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
  photo: widgetbookPlaceholderImageUrl,
  miniaturePhoto: widgetbookPlaceholderImageUrl,
  active: "1",
  showPark: "1",
  lp: "2",
  address: "wybrzeże Stanisława Wyspiańskiego 25",
  trend: "0",
  access: ParkingAccess.students,
);

const meta = Meta<ParkingChart>();

final $default = ParkingChartStory(args: ParkingChartArgs(parking: Arg.fixed(_productionParking)));

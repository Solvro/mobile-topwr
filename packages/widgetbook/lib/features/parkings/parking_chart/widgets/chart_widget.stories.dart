import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/parkings/parking_chart/models/chart_point.dart";
import "package:topwr/features/parkings/parking_chart/widgets/chart_widget.dart";
import "package:topwr/features/parkings/parkings_view/models/parking.dart";
import "package:widgetbook/widgetbook.dart";

part "chart_widget.stories.g.dart";

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
  photo: "https://placehold.co/1200x800/png?text=Parking+C13",
  miniaturePhoto: "https://placehold.co/320x200/png?text=C13",
  active: "1",
  showPark: "1",
  lp: "2",
  address: "wybrzeże Stanisława Wyspiańskiego 25",
  trend: "0",
  access: ParkingAccess.students,
);

const meta = Meta<ChartWidget>();

final $default = ChartWidgetStory(
  args: ChartWidgetArgs(chartData: Arg.fixed(const IList<ChartPoint>.empty()), parking: Arg.fixed(_productionParking)),
);

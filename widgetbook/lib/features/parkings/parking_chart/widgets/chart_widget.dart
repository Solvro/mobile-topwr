import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/parkings/parking_chart/models/chart_point.dart";
import "package:topwr/features/parkings/parking_chart/widgets/chart_widget.dart";
import "package:topwr/features/parkings/parkings_view/models/parking.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ChartWidget)
Widget useCaseChartWidget(BuildContext context) {
  final chartData = [const ChartPoint(0, 10), const ChartPoint(1, 20)].lock;
  const parking = Parking(
    id: "1",
    parkingId: "1A",
    numberOfPlaces: "100",
    symbol: "P1",
    type: "Underground",
    name: "Parking Lot 1",
    openHour: "06:00",
    closeHour: "22:00",
    places: "100",
    geoLan: "19.938",
    geoLat: "50.061",
    photo: "photo.png",
    miniaturePhoto: "mini.png",
    active: "true",
    showPark: "yes",
    lp: "001",
    address: "123 Main St.",
    trend: "up",
    access: ParkingAccess.all,
  );
  return ChartWidget(chartData, parking);
}

import "dart:math";

import "package:collection/collection.dart";
import "package:fl_chart/fl_chart.dart";

import "../../../config/ui_config.dart";
import "../../parkings_view/models/parking.dart";
import "../models/chart_point.dart";
import "../models/hour_label.dart";

extension ChartUtilsX on List<ChartPoint> {
  double get minX => first.x;
  double get maxX => last.x;

  double maxY(Parking parking) => max(
        double.tryParse(parking.places) ?? 0,
        map((e) => e.y).max,
      );

  static String getLabelForValue(double numHourValue) {
    final hourPoint = HourLabel(numHourValue);
    if (!ParkingChartConfig.showLabels.contains(hourPoint)) {
      return "";
    }
    return hourPoint.toStringRepr();
  }

  static bool showDotOrNot(FlSpot spot, LineChartBarData barData) {
    return ParkingChartConfig.showDots.contains(spot.x);
  }
}

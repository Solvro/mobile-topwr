import "package:collection/collection.dart";
import "package:fl_chart/fl_chart.dart";

import "hour_label.dart";
import "raw_chart_data.dart";

class ChartPoint extends FlSpot {
  const ChartPoint(super.x, super.y);

  ChartPoint.parse(String label, String value)
      : super(
          HourLabel.parse(label),
          double.tryParse(value) ?? 0,
        );
}

extension ToCharPointsX on RawChartData {
  Iterable<ChartPoint> toChartPoints() sync* {
    for (final pair in IterableZip(
      [labels, data],
    )) {
      yield ChartPoint.parse(pair.first, pair.last);
    }
  }
}

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

import 'chart_data_model.dart';
import 'hour_label.dart';

class ChartPoint extends FlSpot {
  ChartPoint(super.x, super.y);

  ChartPoint.parse(String label, String value)
      : super(
          HourLabel.parse(label),
          double.tryParse(value) ?? 0,
        );
}

extension ToCharPointsExt on RawChartData {
  Iterable<ChartPoint> toChartPoints() sync* {
    for (var pair in IterableZip(
      [labels, data],
    )) {
      yield ChartPoint.parse(pair.first, pair.last);
    }
  }
}

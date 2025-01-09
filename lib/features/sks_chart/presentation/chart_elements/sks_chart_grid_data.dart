import "package:fl_chart/fl_chart.dart";
import "package:flutter/cupertino.dart";

import "../../../parking_chart/chart_elements/chart_grid.dart";

class SksChartGridData extends FlGridData {
  SksChartGridData(BuildContext context, double horizontalInterval)
      : super(
          verticalInterval: 100,
          horizontalInterval: horizontalInterval,
          getDrawingHorizontalLine: (value) => GridLine(context),
          getDrawingVerticalLine: (value) => GridLine(context),
        );
}

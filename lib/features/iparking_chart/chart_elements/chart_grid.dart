import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";

class GridLine extends FlLine {
  GridLine(BuildContext context)
      : super(
          color: context.colorTheme.greyPigeon,
          dashArray: const [4, 2],
          strokeWidth: 0.5,
        );
}

class ChartGrid extends FlGridData {
  ChartGrid(BuildContext context)
      : super(
          show: true,
          verticalInterval: 2,
          getDrawingHorizontalLine: (value) => GridLine(context),
          getDrawingVerticalLine: (value) => GridLine(context),
        );
}

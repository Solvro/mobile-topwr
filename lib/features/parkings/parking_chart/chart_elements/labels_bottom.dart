import "package:fl_chart/fl_chart.dart";
import "package:flutter/widgets.dart";

import "../../../../theme/app_theme.dart";
import "../utils/chart_utils.dart";

class BottomLabels extends AxisTitles {
  BottomLabels(BuildContext context)
      : super(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (double val, _) => SideTitleWidget(
              axisSide: AxisSide.bottom,
              child: Text(
                ChartUtilsX.getLabelForValue(val),
                style: context.iParkingTheme.chart,
              ),
            ),
          ),
        );
}

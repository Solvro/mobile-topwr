import "package:fl_chart/fl_chart.dart";
import "package:flutter/widgets.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/angles.dart";
import "../utils/chart_utils.dart";

const double rotationAngle = -45;

class BottomLabels extends AxisTitles {
  BottomLabels(BuildContext context)
    : super(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          reservedSize: 48,
          getTitlesWidget:
              (double val, _) => Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Transform.rotate(
                  angle: rotationAngle.radians,
                  child: SideTitleWidget(
                    axisSide: AxisSide.bottom,
                    child: Text(ChartUtilsX.getLabelForValue(val), style: context.iParkingTheme.chart),
                  ),
                ),
              ),
        ),
      );
}

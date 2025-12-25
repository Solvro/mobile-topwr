import "package:fl_chart/fl_chart.dart";
import "package:flutter/widgets.dart";

import "../../../../theme/iparking_theme.dart";
import "../../../../utils/angles.dart";
import "../../../../utils/context_extensions.dart";
import "../utils/chart_utils.dart";

const double rotationAngle = -45;

class BottomLabels extends AxisTitles {
  BottomLabels(BuildContext context)
    : super(
        sideTitles: SideTitles(
          showTitles: true,
          interval: context.isTextScaledDown ? 1 : 3,
          reservedSize: 48,
          getTitlesWidget: (double val, TitleMeta meta) => Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Transform.rotate(
              angle: rotationAngle.radians,
              child: SideTitleWidget(
                meta: meta,
                child: Text(ChartUtilsX.getLabelForValue(val), style: const ParkingChartTextStyle()),
              ),
            ),
          ),
        ),
      );
}

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../models/chart_point.dart";
import "../utils/chart_utils.dart";

class ChartLine extends LineChartBarData {
  ChartLine(BuildContext context, IList<ChartPoint> chartData)
      : super(
          isCurved: false,
          color: context.colorTheme.greyLight,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            checkToShowDot: ChartUtilsX.showDotOrNot,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: context.colorTheme.blueAzure.withValues(alpha: 255.0 * 0.2),
          ),
          spots: chartData.unlockLazy,
        );
}

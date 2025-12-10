import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";

import "../../../../theme/app_theme.dart";
import "../models/chart_point.dart";

class ChartLine extends LineChartBarData {
  ChartLine(BuildContext context, IList<ChartPoint> chartData)
    : super(
        isCurved: false,
        color: context.colorScheme.surfaceTint,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: true, color: context.colorScheme.secondary.withValues(alpha: 0.2)),
        spots: chartData.unlockLazy,
      );
}

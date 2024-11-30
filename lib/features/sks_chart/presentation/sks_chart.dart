import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../theme/colors.dart";
import "../../../widgets/chart_elements.dart";
import "../data/models/sks_chart_data.dart";
import "chart_elements/sks_chart_bar_touch_data.dart";
import "chart_elements/sks_chart_border_data.dart";
import "chart_elements/sks_chart_grid_data.dart";
import "chart_elements/sks_chart_labels.dart";

class SksChart extends StatelessWidget {
  const SksChart({
    required this.maxNumberOfUsers,
    required this.asyncChartData,
  });

  final double maxNumberOfUsers;
  final AsyncValue<IList<SksChartData>> asyncChartData;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: BarChart(
        duration : Duration.zero,
        BarChartData(
          barGroups: asyncChartData.value
              ?.asMap()
              .entries
              .map<BarChartGroupData>((entry) {
            final data = entry.value;
            final isPredicted =
                data.externalTimestamp.isAfter(DateTime.now()) ||
                    (data.externalTimestamp.isAtSameMomentAs(DateTime.now()) &&
                        data.activeUsers == 0);
            return _makeSksChartBar(
              x: entry.key,
              y: isPredicted ? data.movingAverage21 : data.activeUsers,
              isPredicted: isPredicted,
            );
          }).toList(),
          maxY: maxNumberOfUsers + (maxNumberOfUsers / 10).toInt(),
          alignment: BarChartAlignment.spaceAround,
          backgroundColor: context.colorTheme.whiteSoap,
          titlesData: FlTitlesData(
            topTitles: const HideLabels(),
            leftTitles: const HideLabels(),
            rightTitles: SksChartRightTiles(context),
            bottomTitles: SksChartBottomTitles(
              context,
              asyncChartData.value ?? const IList.empty(),
            ),
          ),
          barTouchData: SksChartBarTouchData(context),
          gridData: const SksChartGridData(),
          borderData: SksChartBorderData(),
        ),
      ),
    );
  }
}

BarChartGroupData _makeSksChartBar({
  required int x,
  required int y,
  bool isPredicted = false,
}) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        width: 15,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(SksChartConfig.borderRadius),
        ),
        toY: y.toDouble(),
        color:
            isPredicted ? Colors.transparent : ColorsConsts.orangePomegranade,
        borderDashArray:
            isPredicted ? [SksChartConfig.borderDashArray.toInt()] : null,
        borderSide: isPredicted ? const BorderSide() : null,
      ),
    ],
  );
}

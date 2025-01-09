import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../theme/colors.dart";
import "../../../../widgets/charts/hide_labels.dart";
import "../../data/models/sks_chart_data.dart";
import "sks_chart_grid_data.dart";
import "sks_chart_labels.dart";
import "sks_chart_line_touch_data.dart";

class SksChart extends StatelessWidget {
  const SksChart({
    required this.maxNumberOfUsers,
    required this.chartData,
  });

  final double maxNumberOfUsers;
  final IList<SksChartData> chartData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: SksChartConfig.paddingLarge),
      child: AspectRatio(
        aspectRatio: 1.5,
        child: LineChart(
          duration: Duration.zero,
          LineChartData(
            clipData: const FlClipData.all(),
            backgroundColor: context.colorTheme.whiteSoap,
            gridData: SksChartGridData(context, maxNumberOfUsers / 5),
            maxY: maxNumberOfUsers + (maxNumberOfUsers / 10).toInt(),
            lineBarsData: [
              LineChartBarData(
                belowBarData: BarAreaData(
                  show: true,
                  gradient: ColorsConsts.toPwrGradient,
                  applyCutOffY: true,
                ),
                isCurved: true,
                color: context.colorTheme.orangePomegranade,
                dotData: FlDotData(
                  checkToShowDot: (FlSpot spot, LineChartBarData barData) {
                    return false;
                  },
                ),
                spots: chartData.asMap().entries.map<FlSpot>((e) {
                  if (e.value.externalTimestamp.isAfter(DateTime.now())) {
                    return FlSpot.nullSpot;
                  } else {
                    return FlSpot(
                      e.key.toDouble(),
                      e.value.activeUsers.toDouble(),
                    );
                  }
                }).toList(),
              ),
              LineChartBarData(
                isCurved: true,
                dashArray: [
                  SksChartConfig.borderDashArray.toInt(),
                  SksChartConfig.borderDashArray.toInt(),
                ],
                dotData: FlDotData(
                  checkToShowDot: (FlSpot spot, LineChartBarData barData) {
                    return false;
                  },
                ),
                barWidth: 1.25,
                color: context.colorTheme.blueAzure,
                spots: chartData.asMap().entries.map<FlSpot>((e) {
                  return FlSpot(
                    e.key.toDouble(),
                    e.value.movingAverage21.toDouble(),
                  );
                }).toList(),
              ),
              // this is the biggest hack you'll ever see in your life
              // this is transparent data const = 0 that allows the chart to have a hour tooltip
              LineChartBarData(
                color: Colors.transparent,
                spots: chartData.asMap().entries.map<FlSpot>((e) {
                  return FlSpot(
                    e.key.toDouble(),
                    0,
                  );
                }).toList(),
              ),
            ],
            titlesData: FlTitlesData(
              topTitles: const HideLabels(),
              rightTitles: const HideLabels(),
              leftTitles: SksChartRightTiles(context),
              bottomTitles: SksChartBottomTitles(
                context,
                chartData,
              ),
            ),
            lineTouchData: SksChartLineTouchData(
              context,
              chartData.map((e) => e.externalTimestamp).toIList(),
            ),
          ),
        ),
      ),
    );
  }
}

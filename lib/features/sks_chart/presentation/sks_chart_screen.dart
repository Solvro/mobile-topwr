import "package:auto_route/annotations.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../about_us_view/utils/custom_license_dialog.dart";
import "../data/repository/sks_chart_repository.dart";


// TODO: after click the hover should be int instead of double

@RoutePage()
class SksChartView extends ConsumerWidget {
  const SksChartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChartData = ref.watch(getLatestChartDataProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 250),
          child: BarChart(
            BarChartData(
              gridData: const FlGridData(
                drawHorizontalLine: false,
                drawVerticalLine: false,
              ),
              maxY: 75,
              barGroups: [
                BarChartGroupData(x: 1105, barRods: [BarChartRodData(toY: 12),]),
                BarChartGroupData(x: 1110, barRods: [BarChartRodData(toY: 23)]),
                BarChartGroupData(x: 1115, barRods: [BarChartRodData(toY: 26)]),
                BarChartGroupData(x: 1120, barRods: [BarChartRodData(toY: 29)]),
                BarChartGroupData(x: 1125, barRods: [BarChartRodData(toY: 35, color: Colors.transparent, borderDashArray: [4], borderSide: const BorderSide())]),
                BarChartGroupData(x: 1140, barRods: [BarChartRodData(toY: 50, color: Colors.transparent, borderDashArray: [4], borderSide: const BorderSide())]),
                BarChartGroupData(x: 1145, barRods: [BarChartRodData(toY: 45, color: Colors.transparent, borderDashArray: [4], borderSide: const BorderSide())
                ,],),
              ],
              alignment: BarChartAlignment.spaceAround,
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  axisNameWidget: Text("Ilość osób"),
                  axisNameSize: 40,
                ),
                topTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return Text(
                          style: context.textTheme.body.copyWith(fontSize: 12),
                          (value / 100)
                              .toStringAsFixed(2)
                              .replaceRange(2, 3, ":"));
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

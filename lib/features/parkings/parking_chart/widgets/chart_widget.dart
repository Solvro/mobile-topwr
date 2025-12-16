import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/charts/hide_labels.dart";
import "../../parkings_view/models/parking.dart";
import "../chart_elements/chart_border.dart";
import "../chart_elements/chart_grid.dart";
import "../chart_elements/chart_line.dart";
import "../chart_elements/labels_bottom.dart";
import "../chart_elements/labels_left.dart";
import "../models/chart_point.dart";
import "../models/hour_label.dart";
import "../utils/chart_utils.dart";
import "reversed_label.dart";

class ChartWidget extends StatelessWidget {
  const ChartWidget(this.chartData, this.parking, {super.key});

  final IList<ChartPoint> chartData;
  final Parking parking;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          "${context.localize.parking_chart_max_today_screen_reader_label} ${chartData.reduce((a, b) => a.y > b.y ? a : b).y.toInt()}",
      child: Row(
        children: [
          const ReversedLabel(),
          Expanded(
            child: ExcludeSemantics(
              child: LineChart(
                LineChartData(
                  borderData: ChartBorder(context),
                  gridData: ChartGrid(context),
                  titlesData: FlTitlesData(
                    rightTitles: const HideLabels(),
                    topTitles: const HideLabels(),
                    bottomTitles: BottomLabels(context),
                    leftTitles: LeftLabels(context),
                  ),
                  lineBarsData: [ChartLine(context, chartData)],
                  minX: chartData.minX,
                  maxX: chartData.maxX,
                  maxY: chartData.maxY(parking),
                  minY: 0,
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((touchedSpot) {
                          final hour = HourLabel(touchedSpot.x).toStringRepr();
                          final value = touchedSpot.y.toInt().toString();
                          return LineTooltipItem(
                            "$value\n",
                            TextStyle(
                              color: context.colorScheme.surface,
                              fontWeight: FontWeight.bold,
                              fontSize: ParkingChartConfig.labelFontSize,
                            ),
                            children: [
                              TextSpan(
                                text: hour,
                                style: TextStyle(
                                  color: context.colorScheme.surfaceTint,
                                  fontWeight: FontWeight.normal,
                                  fontSize: ParkingChartConfig.labelFontSize,
                                ),
                              ),
                            ],
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

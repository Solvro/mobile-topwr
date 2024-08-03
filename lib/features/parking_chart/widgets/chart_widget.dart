import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";

import "../../parkings_view/models/parking.dart";
import "../chart_elements/chart_border.dart";
import "../chart_elements/chart_grid.dart";
import "../chart_elements/chart_line.dart";
import "../chart_elements/labels_bottom.dart";
import "../chart_elements/labels_left.dart";
import "../models/chart_point.dart";
import "../utils/chart_utils.dart";
import "reversed_label.dart";

class ChartWidget extends StatelessWidget {
  const ChartWidget(this.chartData, this.parking, {super.key});

  final List<ChartPoint> chartData;
  final Parking parking;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ReversedLabel(),
        Expanded(
          child: LineChart(
            LineChartData(
              borderData: ChartBorder(context),
              gridData: ChartGrid(context),
              titlesData: FlTitlesData(
                rightTitles: const _HideLabels(),
                topTitles: const _HideLabels(),
                bottomTitles: BottomLabels(context),
                leftTitles: LeftLabels(context),
              ),
              lineBarsData: [ChartLine(context, chartData)],
              minX: chartData.minX,
              maxX: chartData.maxX,
              maxY: chartData.maxY(parking),
              minY: 0,
            ),
          ),
        ),
      ],
    );
  }
}

class _HideLabels extends AxisTitles {
  const _HideLabels() : super(sideTitles: const SideTitles());
}

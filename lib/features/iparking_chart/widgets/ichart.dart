import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";

import "../../iparking/models/parking_model.dart";
import "../chart_elements/chart_border.dart";
import "../chart_elements/chart_grid.dart";
import "../chart_elements/chart_line.dart";
import "../chart_elements/labels_bottom.dart";
import "../chart_elements/labels_left.dart";
import "../models/chart_point.dart";
import "../utils/chart_utils.dart";
import "reversed_label.dart";

class IChart extends StatelessWidget {
  const IChart(this.chartData, this.parkingPlace, {super.key});

  final List<ChartPoint> chartData;
  final ParkingPlace parkingPlace;

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
                rightTitles: const HideLabels(),
                topTitles: const HideLabels(),
                bottomTitles: BottomLabels(context),
                leftTitles: LeftLabels(context),
              ),
              lineBarsData: [ChartLine(context, chartData)],
              minX: chartData.minX,
              maxX: chartData.maxX,
              maxY: chartData.maxY(parkingPlace),
              minY: 0,
            ),
          ),
        ),
      ],
    );
  }
}

class HideLabels extends AxisTitles {
  const HideLabels() : super(sideTitles: const SideTitles());
}

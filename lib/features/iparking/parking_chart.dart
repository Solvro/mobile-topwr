import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../theme/iparking_theme.dart';
import '../../utils/where_non_null_iterable.dart';
import '../../widgets/loading_widgets/simple_previews/preview_card_loading.dart';
import '../../widgets/my_error_widget.dart';
import 'models/chart_data_model.dart';
import 'models/parking_model.dart';
import 'repositories/chart_repo.dart';

class ParkingChart extends ConsumerWidget {
  const ParkingChart(this.parkingPlace, {super.key});

  final ParkingPlace parkingPlace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartData = ref.watch(chartRepoProvider.call(parkingPlace));
    return switch (chartData) {
      AsyncLoading() => const PreviewCardLoading(height: 140, width: 240),
      AsyncError(:final error) => MyErrorWidget(error.toString()),
      AsyncValue(:final value) =>
        value == null ? const SizedBox.shrink() : _Chart(value, parkingPlace),
    };
  }
}

class _Chart extends StatelessWidget {
  const _Chart(this.chartData, this.parkingPlace);

  final ChartData chartData;
  final ParkingPlace parkingPlace;

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      gridData: FlGridData(
        show: true,
        verticalInterval: 2,
        getDrawingHorizontalLine: (value) => GridLine(context),
        getDrawingVerticalLine: (value) => GridLine(context),
      ),
      titlesData: FlTitlesData(
        rightTitles: const _HideLabels(),
        topTitles: const _HideLabels(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            getTitlesWidget: chartData.getLabel,
            showTitles: true,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            getTitlesWidget: (value, meta) => SideTitleWidget(
              axisSide: AxisSide.left,
              space: 10,
              child: Text(
                value.toInt().toString(),
                style: const ParkingTextStyle(shadows: [], fontSize: 10),
              ),
            ),
            showTitles: true,
            reservedSize: 30,
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: false,
          color: context.colorTheme.greyLight,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            checkToShowDot: chartData.checkToShowDot,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: context.colorTheme.blueAzure.withOpacity(0.2),
          ),
          spots: chartData.labels
              .mapIndexed(chartData.getPointForIndex)
              .whereNonNull
              .toList(),
        ),
      ],
      minX: chartData.minX,
      maxX: chartData.maxX,
      maxY: chartData.maxY(parkingPlace),
      minY: 0,
    ));
  }
}

class GridLine extends FlLine {
  GridLine(BuildContext context)
      : super(
          color: context.colorTheme.greyPigeon,
          dashArray: const [4, 2],
          strokeWidth: 0.5,
        );
}

class _HideLabels extends AxisTitles {
  const _HideLabels() : super(sideTitles: const SideTitles(showTitles: false));
}

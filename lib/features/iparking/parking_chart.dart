import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../utils/where_non_null_iterable.dart';
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
      AsyncLoading() => const CircularProgressIndicator(),
      AsyncError(:final error, :final stackTrace) =>
        MyErrorWidget(error.toString() + stackTrace.toString()),
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
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        rightTitles: const _HideLabels(),
        topTitles: const _HideLabels(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            getTitlesWidget: chartData.getLabelForIndex,
            showTitles: true,
            interval: 16,
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          color: context.colorTheme.orangePomegranade,
          barWidth: 8,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: chartData.labels
              .mapIndexed(chartData.getPointForIndex)
              .whereNonNull
              .toList(),
        ),
      ],
      minX: 0,
      maxX: chartData.maxX,
      maxY: chartData.maxY(parkingPlace),
      minY: 0,
    ));
  }
}

class _HideLabels extends AxisTitles {
  const _HideLabels() : super(sideTitles: const SideTitles(showTitles: false));
}

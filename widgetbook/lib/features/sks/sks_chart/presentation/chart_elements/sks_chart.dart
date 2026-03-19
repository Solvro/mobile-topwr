import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/features/sks/sks_chart/data/models/sks_chart_data.dart";
import "package:topwr/features/sks/sks_chart/data/repository/sks_chart_repository.dart";
import "package:topwr/features/sks/sks_chart/presentation/chart_elements/sks_chart.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _mockChartData = IList<SksChartData>([
  SksChartData(activeUsers: 100, movingAverage21: 90, externalTimestamp: DateTime(2024, 1, 15, 10)),
  SksChartData(activeUsers: 120, movingAverage21: 100, externalTimestamp: DateTime(2024, 1, 15, 11)),
  SksChartData(activeUsers: 150, movingAverage21: 120, externalTimestamp: DateTime(2024, 1, 15, 12)),
]);

@widgetbook.UseCase(name: "with-mock-data", type: SksChart)
Widget useCaseSksChartMock(BuildContext context) {
  return SksChart(maxNumberOfUsers: 200, chartData: _mockChartData, semanticLabel: "SKS Chart showing user activity");
}

@widgetbook.UseCase(name: "from-production", type: SksChart)
Widget useCaseSksChartProduction(BuildContext context) {
  return const _SksChartFromRepository();
}

class _SksChartFromRepository extends ConsumerWidget {
  const _SksChartFromRepository();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChartData = ref.watch(sksChartRepositoryProvider);
    return asyncChartData.when(
      data: (chartData) {
        if (chartData.isEmpty) {
          return const Center(child: Text("No chart data available"));
        }
        return SksChart(maxNumberOfUsers: 200, chartData: chartData, semanticLabel: "SKS Chart showing user activity");
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text("Error loading chart data: $error")),
    );
  }
}

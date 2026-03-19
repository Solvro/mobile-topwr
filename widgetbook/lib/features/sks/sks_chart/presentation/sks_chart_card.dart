import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/features/sks/sks_chart/data/models/sks_chart_data.dart";
import "package:topwr/features/sks/sks_chart/data/repository/sks_chart_repository.dart";
import "package:topwr/features/sks/sks_chart/presentation/sks_chart_card.dart";
import "package:topwr/features/sks/sks_people_live/data/models/sks_user_data.dart";
import "package:topwr/features/sks/sks_people_live/data/repository/latest_sks_user_data_repo.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _mockSksUserData = SksUserData(
  activeUsers: 150,
  movingAverage21: 120,
  externalTimestamp: DateTime(2024, 1, 15, 12),
  createdAt: DateTime(2024, 1, 15),
  updatedAt: DateTime(2024, 1, 15),
  trend: Trend.stable,
  isResultRecent: true,
  nextUpdateTimestamp: DateTime(2024, 1, 15, 13),
);

final _mockChartData = IList<SksChartData>([
  SksChartData(activeUsers: 100, movingAverage21: 90, externalTimestamp: DateTime(2024, 1, 15, 10)),
  SksChartData(activeUsers: 120, movingAverage21: 100, externalTimestamp: DateTime(2024, 1, 15, 11)),
  SksChartData(activeUsers: 150, movingAverage21: 120, externalTimestamp: DateTime(2024, 1, 15, 12)),
]);

@widgetbook.UseCase(name: "with-mock-data", type: SksChartCard)
Widget useCaseSksChartCardMock(BuildContext context) {
  return SksChartCard(currentNumberOfUsers: _mockSksUserData, maxNumberOfUsers: 200, chartData: _mockChartData);
}

@widgetbook.UseCase(name: "from-production", type: SksChartCard)
Widget useCaseSksChartCardProduction(BuildContext context) {
  return const _SksChartCardFromRepository();
}

class _SksChartCardFromRepository extends ConsumerWidget {
  const _SksChartCardFromRepository();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserData = ref.watch(getLatestSksUserDataProvider);
    final asyncChartData = ref.watch(sksChartRepositoryProvider);
    return asyncUserData.when(
      data: (userData) => asyncChartData.when(
        data: (chartData) {
          if (chartData.isEmpty) {
            return const Center(child: Text("No chart data available"));
          }
          return SksChartCard(currentNumberOfUsers: userData, maxNumberOfUsers: 200, chartData: chartData);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text("Error loading chart data: $error")),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text("Error loading user data: $error")),
    );
  }
}

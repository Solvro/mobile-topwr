import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/features/sks/sks_chart/data/repository/sks_chart_repository.dart";
import "package:topwr/features/sks/sks_chart/presentation/chart_elements/sks_chart.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_chart_production.stories.g.dart";

class SksChartProductionStory extends ConsumerWidget {
  const SksChartProductionStory({super.key});

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

const meta = Meta<SksChartProductionStory>();

final $fromProduction = SksChartProductionStoryStory();

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/features/sks/sks_chart/data/repository/sks_chart_repository.dart";
import "package:topwr/features/sks/sks_chart/presentation/sks_chart_card.dart";
import "package:topwr/features/sks/sks_people_live/data/repository/latest_sks_user_data_repo.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_chart_card_production.stories.g.dart";

class SksChartCardProductionStory extends ConsumerWidget {
  const SksChartCardProductionStory({super.key});

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

const meta = Meta<SksChartCardProductionStory>();

final $fromProduction = SksChartCardProductionStoryStory();

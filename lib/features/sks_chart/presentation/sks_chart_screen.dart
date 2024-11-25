import "package:auto_route/annotations.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/datetime_utils.dart";
import "../data/repository/sks_chart_repository.dart";


@RoutePage()
class SksChartView extends ConsumerWidget {
  const SksChartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChartData = ref.watch(getLatestChartDataProvider);

    return Scaffold(
      body: asyncChartData.when(
        data: (chartDataList) {
          if (chartDataList.isEmpty) {
            return const Center(child: Text("No data available"));
          }
          return ListView.builder(
            itemCount: chartDataList.length,
            itemBuilder: (context, index) {
              final data = chartDataList[index];
              return ListTile(
                title: Text("Timestamp: ${data.externalTimestamp.toDayDateHourString()}"),
                subtitle: Text("Value: ${data.activeUsers}"),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text("Error: $error")),
      ),
    );
  }
}

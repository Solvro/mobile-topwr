import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/sks/sks_chart/data/models/sks_chart_data.dart";
import "package:topwr/features/sks/sks_chart/presentation/chart_elements/sks_chart.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_chart_mock.stories.g.dart";

final _mockChartData = IList<SksChartData>([
  SksChartData(activeUsers: 100, movingAverage21: 90, externalTimestamp: DateTime(2024, 1, 15, 10)),
  SksChartData(activeUsers: 120, movingAverage21: 100, externalTimestamp: DateTime(2024, 1, 15, 11)),
  SksChartData(activeUsers: 150, movingAverage21: 120, externalTimestamp: DateTime(2024, 1, 15, 12)),
]);

class SksChartMockStory extends StatelessWidget {
  const SksChartMockStory({super.key});

  @override
  Widget build(BuildContext context) {
    return SksChart(maxNumberOfUsers: 200, chartData: _mockChartData, semanticLabel: "SKS Chart showing user activity");
  }
}

const meta = Meta(SksChartMockStory.new);

final $withMockData = SksChartMockStoryStory(setup: (context, widget, args) => Column(children: [widget]));

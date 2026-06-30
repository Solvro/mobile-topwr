import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/sks/sks_chart/data/models/sks_chart_data.dart";
import "package:topwr/features/sks/sks_chart/presentation/sks_chart_card.dart";
import "package:topwr/features/sks/sks_people_live/data/models/sks_user_data.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_chart_card_mock.stories.g.dart";

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

class SksChartCardMockStory extends StatelessWidget {
  const SksChartCardMockStory({super.key});

  @override
  Widget build(BuildContext context) {
    return SksChartCard(currentNumberOfUsers: _mockSksUserData, maxNumberOfUsers: 200, chartData: _mockChartData);
  }
}

const meta = Meta(SksChartCardMockStory.new);

final $withMockData = SksChartCardMockStoryStory();

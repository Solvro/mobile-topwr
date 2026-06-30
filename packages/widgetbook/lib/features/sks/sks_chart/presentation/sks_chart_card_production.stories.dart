import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_chart/presentation/sks_chart_card.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../widgetbook_mocks.dart";

part "sks_chart_card_production.stories.g.dart";

class SksChartCardProductionStory extends StatelessWidget {
  const SksChartCardProductionStory({super.key});

  @override
  Widget build(BuildContext context) {
    return SksChartCard(currentNumberOfUsers: mockSksUserData, maxNumberOfUsers: 100, chartData: mockSksChartData);
  }
}

const meta = Meta(SksChartCardProductionStory.new);

final $fromProduction = SksChartCardProductionStoryStory(name: "Hardcoded production snapshot");

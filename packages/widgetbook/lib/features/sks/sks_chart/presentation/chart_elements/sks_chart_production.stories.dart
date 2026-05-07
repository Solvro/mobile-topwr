import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_chart/presentation/chart_elements/sks_chart.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../../widgetbook_mocks.dart";

part "sks_chart_production.stories.g.dart";

class SksChartProductionStory extends StatelessWidget {
  const SksChartProductionStory({super.key});

  @override
  Widget build(BuildContext context) {
    return SksChart(
      maxNumberOfUsers: 100,
      chartData: mockSksChartData,
      semanticLabel: "Wykres liczby osób w Strefie Kultury Studenckiej",
    );
  }
}

const meta = Meta<SksChartProductionStory>();

final $fromProduction = SksChartProductionStoryStory(name: "Hardcoded production snapshot");

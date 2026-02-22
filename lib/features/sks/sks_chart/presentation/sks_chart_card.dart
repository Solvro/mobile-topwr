import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../sks_people_live/data/models/sks_user_data.dart";
import "../../sks_people_live/presentation/widgets/sks_user_data_button.dart";
import "../data/models/sks_chart_data.dart";
import "chart_elements/sks_chart.dart";
import "chart_elements/sks_chart_header.dart";
import "chart_elements/sks_chart_legend.dart";

class SksChartCard extends StatelessWidget {
  const SksChartCard({
    super.key,
    required this.currentNumberOfUsers,
    required this.maxNumberOfUsers,
    required this.chartData,
  });

  final SksUserData? currentNumberOfUsers;
  final double maxNumberOfUsers;
  final IList<SksChartData> chartData;

  @override
  Widget build(BuildContext context) {
    final semanticLabel =
        "${context.localize.sks_chart_title_screen_reader_label} "
        "${context.localize.sks_people_live_screen_reader_label} ${currentNumberOfUsers?.activeUsers.toString() ?? ""}. "
        "${context.localize.sks_people_live_screen_reader_label_trend} ${currentNumberOfUsers?.trend.localizedName(context) ?? ""}. "
        "${context.localize.sks_chart_average_21_days_screen_reader_label} ${chartData.isNotEmpty ? chartData[0].movingAverage21.toString() : "0"}. "
        "${context.localize.sks_chart_max_today_screen_reader_label} ${chartData.maxNumberOfActiveUsers}. "
        "${context.localize.sks_chart_max_21_days_screen_reader_label} ${chartData.maxNumberOfMovingAverage21}";
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: SksChartConfig.paddingMedium),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceTint,
        borderRadius: BorderRadius.circular(SksChartConfig.borderRadius),
      ),
      child: Padding(
        padding: SksChartConfig.paddingLargeLTR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SksChartHeader(
              numberOfPeople: currentNumberOfUsers?.activeUsers.toString() ?? "",
              trend: currentNumberOfUsers?.trend,
            ),
            const SizedBox(height: SksChartConfig.heightLarge),
            SksChart(maxNumberOfUsers: maxNumberOfUsers, chartData: chartData, semanticLabel: semanticLabel),
            const Padding(
              padding: EdgeInsets.only(
                left: SksChartConfig.paddingLarge,
                bottom: SksChartConfig.paddingLarge,
                top: SksChartConfig.paddingSmall,
              ),
              child: SksChartLegend(),
            ),
          ],
        ),
      ),
    );
  }
}

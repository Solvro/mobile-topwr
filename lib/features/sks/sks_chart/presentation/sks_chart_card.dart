import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../sks_people_live/data/models/sks_user_data.dart";
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
    required this.height,
  });

  final SksUserData? currentNumberOfUsers;
  final double maxNumberOfUsers;
  final IList<SksChartData> chartData;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorTheme.greyLight,
        borderRadius: BorderRadius.circular(SksChartConfig.borderRadius),
      ),
      child: Padding(
        padding: SksChartConfig.paddingLargeLTR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SksChartHeader(
              numberOfPeople:
                  currentNumberOfUsers?.activeUsers.toString() ?? "",
              trend: currentNumberOfUsers?.trend,
            ),
            const SizedBox(
              height: SksChartConfig.heightLarge,
            ),
            SizedBox(
              height: 0.5 * height,
              child: SksChart(
                maxNumberOfUsers: maxNumberOfUsers,
                chartData: chartData,
              ),
            ),
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

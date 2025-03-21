import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/cupertino.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../utils/datetime_utils.dart";
import "../../data/models/sks_chart_data.dart";

class SksChartRightTiles extends AxisTitles {
  SksChartRightTiles(BuildContext context)
    : super(
        axisNameWidget: Text(
          context.localize.number_of_people,
          style: context.textTheme.body.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        sideTitles: SideTitles(
          maxIncluded: false,
          reservedSize: 40,
          showTitles: true,
          getTitlesWidget: (double value, TitleMeta meta) {
            return Center(
              child: Text(
                "${value.toInt()}",
                style: context.textTheme.body.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );
}

class SksChartBottomTitles extends AxisTitles {
  SksChartBottomTitles(BuildContext context, IList<SksChartData> chartData)
    : super(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          interval: 5,
          getTitlesWidget: (double value, TitleMeta meta) {
            final DateTime? hourMinute = chartData.isNotEmpty ? chartData[value.toInt()].externalTimestamp : null;
            final String hourMinuteFormatted =
                hourMinute != null && hourMinute.minute == 0 ? hourMinute.toHourMinuteString() : "";

            return Padding(
              padding: const EdgeInsets.only(top: SksChartConfig.paddingSmall, left: 50),
              child: Text(
                style: context.textTheme.body.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                hourMinuteFormatted,
              ),
            );
          },
        ),
      );
}

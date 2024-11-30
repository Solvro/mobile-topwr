import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/cupertino.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/datetime_utils.dart";
import "../../data/models/sks_chart_data.dart";

class SksChartRightTiles extends AxisTitles {
  SksChartRightTiles(BuildContext context)
      : super(
          axisNameWidget: Text(
            context.localize.sks_chart_number_of_users,
            style: context.textTheme.body
                .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          axisNameSize: 35,
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 25,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(
                "${value.toInt()}",
                style: context.textTheme.body
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
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
            getTitlesWidget: (double value, TitleMeta meta) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: SksChartConfig.paddingExtraSmall * 2,
                ),
                child: Text(
                  style: context.textTheme.body
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                  chartData[value.toInt()]
                      .externalTimestamp
                      .toLocal()
                      .toHourMinuteString(),
                ),
              );
            },
          ),
        );
}

import "package:fl_chart/fl_chart.dart";
import "package:flutter/cupertino.dart";

import "../../../../theme/app_theme.dart";

class SksChartBarTouchData extends BarTouchData {
  SksChartBarTouchData(BuildContext context)
      : super(
          enabled: true,
          touchTooltipData: _SksChartTooltipData(context),
        );
}

class _SksChartTooltipData extends BarTouchTooltipData {
  _SksChartTooltipData(BuildContext context)
      : super(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              rod.toY.toStringAsFixed(0),
              context.textTheme.title
                  .copyWith(color: context.colorTheme.whiteSoap),
            );
          },
          getTooltipColor: (barChartGroup) {
            return context.colorTheme.orangePomegranade;
          },
        );
}

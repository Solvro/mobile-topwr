import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/cupertino.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/datetime_utils.dart";

// TODO(mikolaj-jalocha): Sometimes hour label is displayed at the bottom, sometimes between the 2 values.
// TODO(mikolaj-jalocha): Make hour label be always in black (now is red if values were measured, blue otherwise)

class SksChartLineTouchData extends LineTouchData {
  final IList<DateTime> dateTime;

  SksChartLineTouchData(BuildContext context, this.dateTime)
      : super(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (LineBarSpot lineBarSpot) =>
                context.colorTheme.greyLight,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                // display hour always beneath red line or if there's only blue line.
                // this not currently not works exactly as expected, please see todo in the line 8/.
                final bool shouldDisplayHour =
                    touchedSpot.barIndex == 0 || touchedSpots.length == 1;

                final hour = shouldDisplayHour
                    ? "\n${dateTime.get(touchedSpot.x.toInt()).toHourMinuteString()}"
                    : "";

                final value = touchedSpot.y.toStringAsFixed(0) + hour;
                final Color color = (touchedSpot.barIndex == 0)
                    ? context.colorTheme.orangePomegranade
                    : context.colorTheme.blueAzure;
                return LineTooltipItem(
                  value,
                  TextStyle(color: color),
                );
              }).toList();
            },
          ),
        );
}

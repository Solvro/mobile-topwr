import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/cupertino.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/datetime_utils.dart";

class SksChartLineTouchData extends LineTouchData {
  final IList<DateTime> dateTime;

  SksChartLineTouchData(BuildContext context, this.dateTime)
    : super(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (LineBarSpot lineBarSpot) => context.colorScheme.surfaceTint,
          tooltipBorder: BorderSide(color: context.colorScheme.onTertiary),
          getTooltipItems: (touchedSpots) {
            return [
              ...touchedSpots
                  .sorted((a, b) => a.barIndex.compareTo(b.barIndex))
                  .map((LineBarSpot touchedSpot) {
                    final value = touchedSpot.y.toStringAsFixed(0);
                    final textStyle = (touchedSpot.barIndex == 0)
                        ? context.textTheme.titleLarge?.copyWith(color: context.colorScheme.primary, fontSize: 16)
                        : context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.secondary);
                    return LineTooltipItem(value, textStyle!);
                  })
                  .take(touchedSpots.length - 1),
              // hour tooltip
              LineTooltipItem(
                dateTime.get(touchedSpots[0].x.toInt()).toHourMinuteString(context),
                context.textTheme.bodyMedium!,
              ),
            ].toList();
          },
        ),
      );
}

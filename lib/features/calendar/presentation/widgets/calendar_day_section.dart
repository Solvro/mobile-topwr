import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../bussiness/models.dart";
import "../../utils/calendar_view_extension.dart";
import "calendar_tile.dart";

class CalendarDaySection extends StatelessWidget {
  const CalendarDaySection({
    super.key,
    required this.day,
    required this.events,
    required this.weekday,
    this.isToday = false,
  });

  final int day;
  final int weekday;
  final IList<SingleCalendarItem> events;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: HomeViewConfig.paddingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                if (isToday) Text(context.localize.today, style: context.textTheme.bodySmall),
                Text(day.toString(), style: context.textTheme.displayLarge),
                Text(weekday.weekdayToShort(context), style: context.textTheme.bodyMedium),
              ],
            ),
          ),
          Expanded(
            child: Column(
              spacing: HomeViewConfig.paddingSmall,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: events.map(CalendarTile.new).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

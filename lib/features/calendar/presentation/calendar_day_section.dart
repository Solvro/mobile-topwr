import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/wide_tile_card.dart";
import "../data/model/calendar_data.dart";
import "../utils/calendar_view_extension.dart";

class CalendarDaySection extends StatelessWidget {
  const CalendarDaySection({super.key, required this.day, required this.events});

  final int day;
  final IList<CalendarData> events;

  @override
  Widget build(BuildContext context) {
    final weekday = DateTime.parse(events.first.startTime).weekday;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(day.toString(), style: context.textTheme.megaBigHeadline),
              Text(weekday.weekdayToShort(context), style: context.textTheme.boldBody),
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
    );
  }
}

class CalendarTile extends ConsumerWidget {
  const CalendarTile(this.item, {super.key});
  final CalendarData item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WideTileCard(
      title: item.name,
      subtitle: TimeRangeFormatter.getTimeRange(item.startTime, item.endTime),
      secondSubtitle: item.location,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../widgets/wide_tile_card.dart";
import "../data/model/calendar_data.dart";
import "../utils/calendar_view_extension.dart";

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

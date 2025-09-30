import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../widgets/wide_tile_card.dart";
import "../bussiness/models.dart";

class CalendarTile extends ConsumerWidget {
  const CalendarTile(this.item, {super.key});
  final SingleCalendarItem item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WideTileCard(
      title: item.name,
      subtitle: item.hoursString,
      secondSubtitle: item.location.trim().isEmpty ? null : item.location,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}

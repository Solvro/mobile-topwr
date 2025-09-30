import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../bussiness/models.dart";

class CalendarTile extends ConsumerWidget {
  const CalendarTile(this.item, {super.key});
  final SingleCalendarItem item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtitle = item.hoursString.trim() != "00:00 - 00:00"
        ? Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: item.hoursString,
                  style: TextStyle(fontWeight: item.hoursString.trim().contains("-") ? FontWeight.bold : null),
                ),
                if (item.location.trim().isNotEmpty) TextSpan(text: "\n${item.location}"),
              ],
            ),
          )
        : item.location.trim().isNotEmpty
        ? Text(item.location)
        : null;

    return Card(
      color: context.colorTheme.greyLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppWidgetsConfig.borderRadiusMedium)),
      elevation: 0,
      child: ListTile(
        title: Text(item.name),
        titleTextStyle: context.textTheme.title,
        subtitle: subtitle,
        subtitleTextStyle: context.textTheme.body,
      ),
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_alert_dialog.dart";
import "../../bussiness/models.dart";

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
      child: Row(
        children: [
          Container(
            width: 10,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppWidgetsConfig.borderRadiusMedium),
                bottomLeft: Radius.circular(AppWidgetsConfig.borderRadiusMedium),
              ),
              color: item.accentColor,
            ),
          ),
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              title: Text(item.name),
              titleTextStyle: context.textTheme.title,
              subtitle: subtitle,
              subtitleTextStyle: context.textTheme.body,
              trailing: switch (item.description) {
                null => null,
                final description => IconButton(
                  color: context.colorTheme.orangePomegranade,
                  onPressed: () async {
                    await showCustomDialog(
                      dialogSemantics: context.localize.push_notifications_dialog_info,
                      context: context,
                      onConfirmTapped: null,
                      confirmText: context.localize.confirm,
                      dialogContent: Text(description, style: context.textTheme.lightTitle),
                      closeText: context.localize.ok,
                    );
                  },
                  icon: const Icon(Icons.info_outline),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

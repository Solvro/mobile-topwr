import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../config/ui_config.dart";
import "../theme/app_theme.dart";
import "../utils/context_extensions.dart";

class DateChip extends StatelessWidget {
  const DateChip({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: context.colorScheme.onTertiary, borderRadius: BorderRadius.circular(20)),
        child: Text(
          DateFormat(DateChipConfig.dateTimeFormat, context.locale.languageCode).format(date),
          style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.surface, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

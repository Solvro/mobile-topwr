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
        decoration: BoxDecoration(color: context.colorTheme.blackMirage, borderRadius: BorderRadius.circular(20)),
        child: Text(
          DateFormat(DateChipConfig.dateTimeFormat, context.locale.countryCode).format(date),
          style: context.textTheme.bodyWhite.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

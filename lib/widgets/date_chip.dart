import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/ui_config.dart';
import '../theme/app_theme.dart';

class DateChip extends StatelessWidget {
  const DateChip({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: context.colorTheme.blackMirage,
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            DateFormat(DateChipConfig.dateTimeFormat).format(date),
            style: context.textTheme.bodyWhite,
          ),
        ));
  }
}

import 'package:flutter/material.dart';

import '../../../../config.dart';
import '../../../../theme/app_theme.dart';
import '../../repository/academic_calendar_repo.dart';
import '../../utils/counter_digits.dart';

class DigitsRow extends StatelessWidget {
  const DigitsRow(this.calendarData, {super.key});
  final AcademicCalendar? calendarData;

  @override
  Widget build(BuildContext context) {
    final dayLeftString = calendarData?.daysLeftFromNowString;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final digit in Digit.values)
          IntBox(
            singleInt: dayLeftString?.getDigit(digit) ??
                CountdownConfig.defaultDigit.toString(),
          ),
      ],
    );
  }
}

class IntBox extends StatelessWidget {
  final String singleInt;
  const IntBox({
    super.key,
    required this.singleInt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: context.colorTheme.whiteSoap,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66c62d2e),
            offset: Offset(-1, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          singleInt,
          style: context.textTheme.headline,
        ),
      ),
    );
  }
}

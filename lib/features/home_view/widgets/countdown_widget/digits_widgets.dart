import 'package:flutter/material.dart';
import '../../../../config.dart';
import '../../utils/days_left_digits.dart';
import '../../../../theme/app_theme.dart';

class DigitsRow extends StatelessWidget {
  const DigitsRow(this.endDate, {super.key});
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final dayLeftString = endDate?.daysLeftFromNowString;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final digit in Digit.values)
          IntBox(
            singleInt: dayLeftString?.getDigit(digit) ??
                ExamSessionCountdownConfig.defaultDigit,
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
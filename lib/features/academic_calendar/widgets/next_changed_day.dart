import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/datetime_utils.dart";
import "../model/academic_calendar_extensions.dart";
import "../repository/academic_calendar_repo.dart";
import "../utils/localize_academic_day.dart";

class NextChangedDay extends StatelessWidget {
  const NextChangedDay({super.key, required this.academicCalendar});

  final AcademicCalendar academicCalendar;

  @override
  Widget build(BuildContext context) {
    final nextChangedDay = academicCalendar.nextChangedDay;
    if (nextChangedDay == null) {
      return const SizedBox.shrink();
    }
    final boldStyle = context.greetingTheme.boldTextStyle.copyWith(fontSize: 16);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: context.greetingTheme.textStyle.copyWith(fontSize: 16),
          children: [
            const TextSpan(text: "Następna zamiana dnia już za "),
            TextSpan(text: nextChangedDay.dateTime.daysLeftFromNow.toString(), style: boldStyle),
            TextSpan(
              text:
                  " dni (${nextChangedDay.dateTime.toDayDateString(context, includeWeekday: false, includeYear: false)}) ",
              style: boldStyle,
            ),

            const TextSpan(text: " z "),
            TextSpan(
              text: nextChangedDay.standardAcademicDay.localize(context, includePrefix: false),
              style: boldStyle,
            ),
            const TextSpan(text: " na "),
            TextSpan(text: nextChangedDay.changedAcademicDay.localize(context, includePrefix: false), style: boldStyle),
          ],
        ),
      ),
    );
  }
}

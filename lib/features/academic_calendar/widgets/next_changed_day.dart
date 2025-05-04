import "package:flutter/material.dart";
import "../../../l10n/app_localizations.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
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
            TextSpan(text: AppLocalizations.of(context)!.next_changed_day_prefix),
            TextSpan(text: nextChangedDay.dateTime.daysLeftFromNow.toString(), style: boldStyle),
            TextSpan(
              text:
                  context.localize.next_changed_day_days +
                  nextChangedDay.dateTime.toDayDateString(context, includeWeekday: false, includeYear: false) +
                  context.localize.next_changed_day_date_suffix,
              style: boldStyle,
            ),
            TextSpan(text: context.localize.next_changed_day_from),
            TextSpan(
              text: nextChangedDay.standardAcademicDay.localize(context, includePrefix: false),
              style: boldStyle,
            ),
            TextSpan(text: context.localize.next_changed_day_to),
            TextSpan(text: nextChangedDay.changedAcademicDay.localize(context, includePrefix: false), style: boldStyle),
          ],
        ),
      ),
    );
  }
}

import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../model/academic_calendar_extensions.dart";
import "../model/academic_calendar_rest_model.dart";
import "../utils/localize_academic_day.dart";

class Greeting extends StatelessWidget {
  const Greeting(this.academicCalendar, {super.key});
  final AcademicCalendarRestData academicCalendar;

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.offline_academic_calendar);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.localize.home_screen_greeting, style: context.greetingTheme.textStyle),
          Text(academicCalendar.standardAcademicDay.localize(context), style: context.greetingTheme.boldTextStyle),
        ],
      ),
    );
  }
}

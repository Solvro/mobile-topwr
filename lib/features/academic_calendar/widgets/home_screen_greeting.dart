import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../model/academic_calendar_extensions.dart";
import "../repository/academic_calendar_repo.dart";
import "../utils/localize_academic_day.dart";

class Greeting extends StatelessWidget {
  const Greeting(
    this.academicCalendar, {
    super.key,
  });
  final AcademicCalendar academicCalendar;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.localize.home_screen_greeting,
            style: context.greetingTheme.textStyle,
          ),
          Text(
            academicCalendar.academicDay?.localize(context) ?? "",
            style: context.greetingTheme.boldTextStyle,
          ),
        ],
      ),
    );
  }
}

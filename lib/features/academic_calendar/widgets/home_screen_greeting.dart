import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../model/academic_calendar_extensions.dart";
import "../repository/academic_calendar_repo.dart";
import "../utils/localize_academic_day.dart";

class Greeting extends StatelessWidget {
  const Greeting(this.academicCalendar, {super.key});
  final AcademicCalendar academicCalendar;
  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 1.5);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.localize.home_screen_greeting, style: context.greetingTheme.textStyle, textScaler: scaler),
          Text(
            academicCalendar.academicDayToday?.localize(context) ?? "",
            style: context.greetingTheme.boldTextStyle,
            textScaler: scaler,
          ),
        ],
      ),
    );
  }
}

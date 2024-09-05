import "package:flutter/material.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../repository/academic_calendar_repo.dart";
import "../../utils/localize_counter_message.dart";
import "digits_widgets.dart";

class ExamSessionCountdown extends StatelessWidget {
  const ExamSessionCountdown(this.academicCalendar, {super.key});

  final AcademicCalendar academicCalendar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        height: 69,
        decoration: BoxDecoration(
          gradient: context.colorTheme.toPwrGradient,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 6,
              blurRadius: 11,
              color: Color(0x28fa6465),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: DigitsRow(academicCalendar),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.localize.days,
                    style: context.textTheme.headlineWhite,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      academicCalendar.localizeDaysCounterMessage(context),
                      style: context.textTheme.bodyWhite,
                      textScaler: const TextScaler.linear(0.97),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

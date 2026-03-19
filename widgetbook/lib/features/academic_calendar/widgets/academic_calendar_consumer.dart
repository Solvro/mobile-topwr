import "package:flutter/widgets.dart";
import "package:topwr/features/academic_calendar/widgets/academic_calendar_consumer.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AcademicCalendarConsumer)
Widget useCaseAcademicCalendarConsumer(BuildContext context) {
  return const AcademicCalendarConsumer();
}

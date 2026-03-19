import "package:flutter/widgets.dart";
import "package:topwr/features/calendar/presentation/calendar_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: CalendarView)
Widget useCaseCalendarView(BuildContext context) {
  return const CalendarView();
}

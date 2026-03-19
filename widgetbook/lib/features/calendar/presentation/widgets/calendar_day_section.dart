import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/calendar/bussiness/models.dart";
import "package:topwr/features/calendar/presentation/widgets/calendar_day_section.dart";
import "package:topwr/theme/hex_color.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _productionEvents = IList<SingleCalendarItem>([
  (
    name: "Analiza matematyczna",
    location: "Budynek C, sala 123",
    hoursString: "08:00 - 09:30",
    description: "Wykład prowadzony przez prof. Nowak",
    accentColor: HexColor("#1976D2"),
  ),
  (
    name: "Fizyka I",
    location: "Budynek F, aula 2",
    hoursString: "10:00 - 11:30",
    description: "Laboratorium prowadzi mgr Zielińska",
    accentColor: HexColor("#388E3C"),
  ),
]);

@widgetbook.UseCase(name: "default", type: CalendarDaySection)
Widget useCaseCalendarDaySection(BuildContext context) {
  return CalendarDaySection(
    day: context.knobs.int.input(label: "Day", initialValue: 15),
    events: _productionEvents,
    weekday: context.knobs.int.input(label: "Weekday", initialValue: 1),
    isToday: context.knobs.boolean(label: "Is today"),
  );
}

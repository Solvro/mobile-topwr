import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:topwr/features/calendar/bussiness/models.dart";
import "package:topwr/features/calendar/presentation/widgets/calendar_day_section.dart";
import "package:topwr/theme/hex_color.dart";
import "package:widgetbook/widgetbook.dart";

part "calendar_day_section.stories.g.dart";

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

class CalendarDaySectionStoryKnobs {
  final int day;
  final int weekday;
  final bool isToday;
  CalendarDaySectionStoryKnobs({required this.day, required this.weekday, required this.isToday});
}

const meta = MetaWithArgs<CalendarDaySection, CalendarDaySectionStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) =>
      CalendarDaySection(day: args.day, events: _productionEvents, weekday: args.weekday, isToday: args.isToday),
);

final $default = CalendarDaySectionStory();

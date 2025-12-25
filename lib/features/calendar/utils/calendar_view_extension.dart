import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "../../../utils/context_extensions.dart";
import "../data/model/calendar_data.dart";

extension CalendarDataDateTime on CalendarData {
  DateTime get startDateTime => DateTime.parse(startTime);
  int get year => startDateTime.year;
  int get month => startDateTime.month;
  int get day => startDateTime.day;
  int get weekday => startDateTime.weekday;
}

extension TimeToHour on String {
  String getHour() {
    final dateTime = DateTime.parse(this);
    final hour = dateTime.hour.toString().padLeft(2, "0");
    final minute = dateTime.minute.toString().padLeft(2, "0");
    return "$hour:$minute";
  }
}

extension MonthFormatter on int {
  String monthToString(BuildContext context) {
    final l10n = context.localize;
    final months = [
      l10n.january,
      l10n.february,
      l10n.march,
      l10n.april,
      l10n.may,
      l10n.june,
      l10n.july,
      l10n.august,
      l10n.september,
      l10n.october,
      l10n.november,
      l10n.december,
    ];
    return months[this - 1];
  }
}

extension WeekdayFormatter on int {
  String weekdayToShort(BuildContext context) {
    final w = context.localize;
    final weekdayShorts = [w.monday, w.tuesday, w.wednesday, w.thursday, w.friday, w.saturday, w.sunday];
    return weekdayShorts[this - 1];
  }
}

extension FilterOutPastEvents on IList<CalendarData> {
  IList<CalendarData> filterOutPastEvents() {
    final now = DateTime.now();
    return where((event) => event.startDateTime.isAfter(now)).toList().lock;
  }
}

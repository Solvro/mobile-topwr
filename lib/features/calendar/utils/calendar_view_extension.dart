import "package:flutter/widgets.dart";
import "../../../utils/context_extensions.dart";
import "../model/calendar_data.dart";

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
    final m = context.localize;
    final months = [
      m.january,
      m.february,
      m.march,
      m.april,
      m.may,
      m.june,
      m.july,
      m.august,
      m.september,
      m.october,
      m.november,
      m.december,
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

class TimeRangeFormatter {
  static String getTimeRange(String startTime, String endTime) {
    final String startHour = startTime.getHour();
    final String endHour = endTime.getHour();
    return "$startHour-$endHour";
  }
}

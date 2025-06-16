import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../utils/datetime_utils.dart";
import "academic_calendar.dart";
import "academic_calendar_extensions.dart";
import "academic_day.dart";
import "day_swap_model.dart";

extension ExceptionDaySwapX on DaySwapData {
  AcademicDay academicDay(AcademicCalendar calendarData) {
    return AcademicDay(
      isEven: changedDayIsEven,
      weekday: changedWeekday,
      isExamSession: calendarData.isExamSession(date),
      isHolidays: calendarData.isHolidays(date),
    );
  }
}

extension AcademicDaySwapListX on IList<DaySwapData> {
  bool _checkIfThisIsToday(DaySwapData element) => element.date.isSameDay(now);

  bool get isTodayAnException {
    return any(_checkIfThisIsToday);
  }

  AcademicDay? changedDayToday(AcademicCalendar calendarData) {
    final changedDayData = firstWhereOrNull(_checkIfThisIsToday);
    return changedDayData?.academicDay(calendarData);
  }

  IList<DaySwapData> nextDaySwapsWithinWindow([Duration? windowDuration]) {
    final duration = windowDuration ?? const Duration(days: 7);
    final nowPlusWindow = now.add(duration);
    return where(
      (element) => (element.date.isAfter(now) && element.date.isBefore(nowPlusWindow)) || element.date.isSameDay(now),
    ).toIList().sort((a, b) => a.date.compareTo(b.date));
  }
}

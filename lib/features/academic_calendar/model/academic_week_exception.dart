import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../utils/datetime_utils.dart";
import "../repository/academic_calendar_repo.dart";
import "academic_calendar_extensions.dart";
import "academic_day.dart";
import "weekday_enum.dart";

extension ExceptionX on AcademicWeekException {
  AcademicDay academicDay(AcademicCalendarData calendarData) {
    return AcademicDay(
      isEven: changedDayIsEven,
      weekday: WeekdayEnum.fromJson(changedWeekday),
      isExamSession: calendarData.isExamSession(day),
      isHolidays: calendarData.isHolidays(day),
    );
  }
}

extension AcademicWeekExceptionX on IList<AcademicWeekException> {
  bool _checkIfThisIsToday(AcademicWeekException element) => element.day.isSameDay(now);

  bool get isTodayAnException {
    return any(_checkIfThisIsToday);
  }

  AcademicDay? changedDayToday(AcademicCalendarData calendarData) {
    final changedDayData = firstWhereOrNull(_checkIfThisIsToday);
    return changedDayData?.academicDay(calendarData);
  }

  IList<AcademicWeekException> nextExceptionsWithinWindow([Duration? windowDuration]) {
    final duration = windowDuration ?? const Duration(days: 7);
    final nowPlusWindow = now.add(duration);
    return where(
      (element) => element.day.isAfter(now) && element.day.isBefore(nowPlusWindow),
    ).toIList().sort((a, b) => a.day.compareTo(b.day));
  }
}

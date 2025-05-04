import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../utils/datetime_utils.dart";
import "../repository/academic_calendar_repo.dart";
import "academic_day.dart";
import "weekday_enum.dart";

extension AcademicWeekExceptionX on IList<AcademicWeekException> {
  bool _checkIfThisIsToday(AcademicWeekException element) => element.day.isSameDay(now);

  bool get isTodayAnException {
    return any(_checkIfThisIsToday);
  }

  AcademicDay? get changedDayToday {
    final changedDayData = firstWhereOrNull(_checkIfThisIsToday);
    return changedDayData != null
        ? AcademicDay(
          isEven: changedDayData.changedDayIsEven,
          isExamSession: false,
          isHolidays: false,
          weekday: WeekdayEnum.fromJson(changedDayData.changedWeekday),
        )
        : null;
  }

  List<AcademicWeekException> nextExceptionsWithinWindow([Duration? windowDuration]) {
    final duration = windowDuration ?? const Duration(days: 7);
    final nowPlusWindow = now.add(duration);
    return where(
      (element) => element.day.isAfter(now) && element.day.isBefore(nowPlusWindow),
    ).sorted((a, b) => a.day.compareTo(b.day));
  }
}

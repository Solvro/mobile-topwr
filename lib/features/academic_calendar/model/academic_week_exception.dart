import "package:collection/collection.dart";

import "../../../utils/datetime_utils.dart";
import "../repository/academic_calendar_repo.dart";
import "academic_day.dart";
import "weekday_enum.dart";

extension AcademicWeekExceptionX on List<AcademicWeekException> {
  bool _checkIfThisIsToday(AcademicWeekException element) =>
      element.day.isSameDay(now);

  bool get isTodayAnException {
    return any(_checkIfThisIsToday);
  }

  AcademicDay? get changedDay {
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
}

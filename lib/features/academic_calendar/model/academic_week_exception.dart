import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../utils/datetime_utils.dart";
import "academic_day.dart";
import "day_swap_model.dart";
import "weekday_enum.dart";

extension AcademicWeekExceptionX on IList<DaySwapData> {
  bool _checkIfThisIsToday(DaySwapData element) => element.date.isSameDay(now);

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

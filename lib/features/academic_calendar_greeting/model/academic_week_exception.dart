import 'package:collection/collection.dart';

import '../repository/academic_calendar_repo.dart';
import '../utils/datetime_utils.dart';
import 'academic_day.dart';
import 'weekday_enum.dart';

extension AcadWeekExceptionExtraAttrs on List<AcademicWeekException> {
  bool _checkIfThisIsToday(AcademicWeekException element) =>
      element.day.isSameDay(now);

  bool get isTodayAnException {
    return any(_checkIfThisIsToday);
  }

  AcademicDay? get changedDay {
    final changedDayData = firstWhereOrNull(_checkIfThisIsToday);
    if (changedDayData == null) return null;
    return AcademicDay(
      isEven: changedDayData.changedDayIsEven,
      weekday: WeekdayEnum.fromJson(changedDayData.changedWeekday),
    );
  }
}

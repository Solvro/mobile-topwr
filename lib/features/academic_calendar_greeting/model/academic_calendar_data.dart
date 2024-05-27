import '../repository/academic_calendar_repo.dart';
import '../utils/datetime_utils.dart';
import 'academic_day.dart';
import 'academic_week_exception.dart';
import 'weekday_enum.dart';

extension AcademicCalendarDataExtraAttrs on AcademicCalendarData {
  bool isHolidays() {
    return now.isBefore(semesterStartDate) || now.isAfter(examSessionLastDay);
  }

  bool isExamSession() {
    return now.isAfter(examSessionStartDate) &&
        now.isBefore(examSessionLastDay);
  }

  bool isSemester() {
    return now.isAfter(semesterStartDate) && now.isBefore(examSessionStartDate);
  }

  bool shouldBeEvenWeek() {
    final zeroMonday = semesterStartDate.findMondayOfTheWeek();
    final numWeeksFromZeroMonday = zeroMonday.calculateWeeksTo(now);
    if (numWeeksFromZeroMonday.isEven) {
      return isFirstWeekEven;
    }
    return !isFirstWeekEven;
  }

  AcademicDay get standardAcademicDay {
    return AcademicDay(
      isEven: shouldBeEvenWeek(),
      weekday: WeekdayEnum.fromDateTime(now),
    );
  }
}

extension AcademicCalendarExtraAttrs on AcademicCalendar {
  AcademicDay? get academicDay {
    if (weeks.isTodayAnException) {
      return weeks.changedDay ?? data?.standardAcademicDay;
    }
    return data?.standardAcademicDay;
  }
}

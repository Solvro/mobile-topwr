import "../../../utils/datetime_utils.dart";
import "../repository/academic_calendar_repo.dart";
import "academic_calendar_rest_model.dart";
import "academic_day.dart";
import "academic_week_exception.dart";
import "weekday_enum.dart";

extension AcademicCalendarDataX on AcademicCalendarRestData {
  bool isHolidays() {
    return now.isBefore(semesterStartDate) || now.isAfter(examSessionLastDate);
  }

  bool isExamSession() {
    return now.isAfterOrSameAs(examSessionStartDate) && now.isBeforeOrSameAs(examSessionLastDate);
  }

  bool isSemester() {
    return now.isAfterOrSameAs(semesterStartDate) && now.isBefore(examSessionStartDate);
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
      isExamSession: isExamSession(),
      isHolidays: isHolidays(),
    );
  }
}

extension AcademicCalendarX on AcademicCalendarData {
  AcademicDay? get academicDay {
    if (weeks.isTodayAnException) {
      return weeks.changedDay ?? data.standardAcademicDay;
    }
    return data.standardAcademicDay;
  }
}

import "../../../utils/datetime_utils.dart";
import "../repository/academic_calendar_repo.dart";
import "academic_day.dart";
import "academic_week_exception.dart";
import "weekday_enum.dart";

extension AcademicCalendarDataX on AcademicCalendarData {
  bool isHolidays([DateTime? datetime]) {
    final datetimeOrNow = datetime ?? now;
    return datetimeOrNow.isBefore(semesterStartDate) || datetimeOrNow.isAfter(examSessionLastDay);
  }

  bool isExamSession([DateTime? datetime]) {
    final datetimeOrNow = datetime ?? now;
    return datetimeOrNow.isAfterOrSameAs(examSessionStartDate) && datetimeOrNow.isBeforeOrSameAs(examSessionLastDay);
  }

  bool isSemester([DateTime? datetime]) {
    final datetimeOrNow = datetime ?? now;
    return datetimeOrNow.isAfterOrSameAs(semesterStartDate) && datetimeOrNow.isBefore(examSessionStartDate);
  }

  bool shouldBeEvenWeek([DateTime? datetime]) {
    final datetimeOrNow = datetime ?? now;
    final zeroMonday = semesterStartDate.findMondayOfTheWeek();
    final numWeeksFromZeroMonday = zeroMonday.calculateWeeksTo(datetimeOrNow);
    if (numWeeksFromZeroMonday.isEven) {
      return isFirstWeekEven;
    }
    return !isFirstWeekEven;
  }

  AcademicDay standardAcademicDay([DateTime? datetime]) {
    final datetimeOrNow = datetime ?? now;
    return AcademicDay(
      isEven: shouldBeEvenWeek(datetimeOrNow),
      weekday: WeekdayEnum.fromDateTime(datetimeOrNow),
      isExamSession: isExamSession(datetimeOrNow),
      isHolidays: isHolidays(datetimeOrNow),
    );
  }
}

extension AcademicCalendarX on AcademicCalendar {
  AcademicDay? get academicDay {
    if (weeks.isTodayAnException) {
      return weeks.changedDayToday ?? data?.standardAcademicDay();
    }
    return data?.standardAcademicDay();
  }

  NextChangedDayData? get nextChangedDay {
    final nextException = weeks.nextException;
    final data = this.data;
    if (nextException == null || data == null) {
      return null;
    }
    return (
      dateTime: nextException.day,
      standardAcademicDay: data.standardAcademicDay(nextException.day),
      changedAcademicDay: AcademicDay(
        isEven: nextException.changedDayIsEven,
        isExamSession: data.isExamSession(nextException.day),
        isHolidays: data.isHolidays(nextException.day),
        weekday: WeekdayEnum.fromJson(nextException.changedWeekday),
      ),
    );
  }
}

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
  Duration get windowDuration => Duration(days: data?.exceptionsLookupFutureWindowInDays ?? 7);

  AcademicDay? get academicDayToday {
    if (weeks.isTodayAnException && data != null) {
      return weeks.changedDayToday(data!) ?? data!.standardAcademicDay();
    }
    return data?.standardAcademicDay();
  }

  ({int daysTillFirstChange, int changesCount})? get incomingDaysChanges {
    final nextException = weeks.nextExceptionsWithinWindow(windowDuration);
    final data = this.data;
    if (data == null || nextException.isEmpty) {
      return null;
    }
    return (daysTillFirstChange: nextException.first.day.difference(now).inDays, changesCount: nextException.length);
  }
}

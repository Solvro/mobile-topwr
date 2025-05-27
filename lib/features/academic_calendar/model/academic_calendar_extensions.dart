import "../../../utils/datetime_utils.dart";
import "../repository/academic_calendar_repo.dart";
import "academic_calendar.dart";
import "academic_day.dart";
import "academic_week_exception.dart";
import "weekday_enum.dart";

extension AcademicCalendarDataX on AcademicCalendar {
  bool isHolidays([DateTime? datetime]) {
    final datetimeOrNow = datetime ?? now;
    return datetimeOrNow.isBefore(semesterStartDate) || datetimeOrNow.isAfter(examSessionLastDate);
  }

  bool isExamSession([DateTime? datetime]) {
    final datetimeOrNow = datetime ?? now;
    return datetimeOrNow.isAfterOrSameAs(examSessionStartDate) && datetimeOrNow.isBeforeOrSameAs(examSessionLastDate);
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

extension AcademicCalendarX on AcademicCalendarWithSwaps {
  Duration get windowDuration => Duration(days: data.exceptionsLookupFutureWindowInDays ?? 7);

  AcademicDay? get academicDayToday {
    if (daySwaps.isTodayAnException) {
      return daySwaps.changedDayToday(data) ?? data.standardAcademicDay();
    }
    return data.standardAcademicDay();
  }

  ({int daysTillFirstChange, int changesCount})? get incomingDaysChanges {
    final nextException = daySwaps.nextDaySwapsWithinWindow(windowDuration);
    if (nextException.isEmpty) {
      return null;
    }
    return (daysTillFirstChange: nextException.first.date.difference(today).inDays, changesCount: nextException.length);
  }
}

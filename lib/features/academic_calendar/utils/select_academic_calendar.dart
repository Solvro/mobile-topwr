import "../../../utils/datetime_utils.dart";
import "../model/academic_calendar.dart";
import "../model/academic_calendar_extensions.dart";
import "../model/day_swap_model.dart";

extension SelectAcademicCalendarX on Iterable<AcademicCalendar> {
  AcademicCalendar? selectCurrentOrUpcoming([DateTime? datetime]) {
    final calendars = toList();
    if (calendars.isEmpty) {
      return null;
    }
    final datetimeOrNow = datetime ?? now;

    final current =
        calendars
            .where((calendar) => calendar.isSemester(datetimeOrNow) || calendar.isExamSession(datetimeOrNow))
            .toList()
          ..sort((a, b) => b.semesterStartDate.compareTo(a.semesterStartDate));
    if (current.isNotEmpty) {
      return current.first;
    }

    final upcoming = calendars.where((calendar) => datetimeOrNow.isBefore(calendar.semesterStartDate)).toList()
      ..sort((a, b) => a.semesterStartDate.compareTo(b.semesterStartDate));
    if (upcoming.isNotEmpty) {
      return upcoming.first;
    }

    calendars.sort((a, b) => b.examSessionLastDate.compareTo(a.examSessionLastDate));
    return calendars.first;
  }

  bool hasCurrentOrUpcoming([DateTime? datetime]) {
    final datetimeOrNow = datetime ?? now;
    return any((calendar) => datetimeOrNow.isBeforeOrSameAs(calendar.examSessionLastDate));
  }
}

extension SelectDaySwapsX on Iterable<DaySwapData> {
  Iterable<DaySwapData> forAcademicCalendar(int academicCalendarId) {
    return where((swap) => swap.academicCalendarId == academicCalendarId);
  }

  bool hasUpcomingOrToday([DateTime? datetime]) {
    final datetimeOrNow = datetime ?? now;
    return any((swap) => swap.date.isAfter(datetimeOrNow) || swap.date.isSameDay(datetimeOrNow));
  }
}

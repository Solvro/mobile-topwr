import "package:flutter/cupertino.dart";

import "../../../utils/context_extensions.dart";
import "../model/academic_calendar_extensions.dart";
import "../repository/academic_calendar_repo.dart";

extension LocalizeCounterMessageX on AcademicCalendar {
  String localizeDaysCounterMessage(BuildContext context) {
    final calendarData = this.AcademicCalendarData;
    if (calendarData != null) {
      if (calendarData.isHolidays()) {
        return context.localize.until_the_end_of_the_semester_break;
      } else if (calendarData.isExamSession()) {
        return context.localize.until_the_session_ends;
      }
    }
    return context.localize.to_start_session;
  }
}

import "package:flutter/cupertino.dart";

import "../../../utils/context_extensions.dart";
import "../model/academic_calendar_extensions.dart";
import "../repository/academic_calendar_repo.dart";

extension LocalizeCounterMessageExtension on AcademicCalendar {
  String localizeDaysCounterMessage(BuildContext context) {
    if (this.AcademicCalendarData!.isHolidays()) return context.localize.until_the_end_of_the_semester_break;
    if (this.AcademicCalendarData!.isExamSession()) return context.localize.until_the_session_ends;
    return context.localize.days;
  }
}

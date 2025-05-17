import "dart:math";

import "../../../config/ui_config.dart";
import "../../../utils/datetime_utils.dart";
import "../model/academic_calendar_extensions.dart";
import "../repository/academic_calendar_repo.dart";

enum Digit { first, second, third }

extension DaysLeftStringConverterX on AcademicCalendarData {
  String get daysLeftFromNowString {
    final calendarData = this.calendarData;
    final daysLeft =
        calendarData != null
            ? (data.isHolidays()
                ? data.semesterStartDate.daysLeftFromNow
                : data.isExamSession()
                ? data.examSessionLastDate.daysLeftFromNow
                : data.examSessionStartDate.daysLeftFromNow)
            : null;

    return max(_default, daysLeft ?? _default).toString().padLeft(Digit.values.length, _default.toString());
  }
}

extension GetDigitX on String {
  String getDigit(Digit digit) => length > digit.index ? this[digit.index] : _default.toString();
}

int get _default => CountdownConfig.defaultDigit;

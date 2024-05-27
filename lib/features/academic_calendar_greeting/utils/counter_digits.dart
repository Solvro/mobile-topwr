import 'dart:math';

import '../../../config.dart';
import '../../../utils/datetime_utils.dart';
import '../repository/academic_calendar_repo.dart';

enum Digit { first, second, third }

int get _default => ExamSessionCountdownConfig.defaultDigit;
String get _defaultStr => ExamSessionCountdownConfig.defaultStrDigit;

extension DaysLeftStringConverter on AcademicCalendar {
  String get daysLeftFromNowString => max(
        0,
        data?.examSessionStartDate.daysLeftFromNow ?? _default,
      ).toString().padLeft(
            Digit.values.length,
            _defaultStr,
          );
}

extension GetDigitExtension on String {
  String getDigit(Digit digit) =>
      length > digit.index ? this[digit.index] : _defaultStr;
}

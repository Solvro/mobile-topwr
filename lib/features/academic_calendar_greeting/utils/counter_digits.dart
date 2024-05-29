import 'dart:math';

import '../../../config.dart';
import '../../../utils/datetime_utils.dart';
import '../repository/academic_calendar_repo.dart';

enum Digit { first, second, third }

extension DaysLeftStringConverter on AcademicCalendar {
  String get daysLeftFromNowString => max(
        _default,
        data?.examSessionStartDate.daysLeftFromNow ?? _default,
      ).toString().padLeft(
            Digit.values.length,
            _default.toString(),
          );
}

extension GetDigitExtension on String {
  String getDigit(Digit digit) =>
      length > digit.index ? this[digit.index] : _default.toString();
}

int get _default => CountdownConfig.defaultDigit;

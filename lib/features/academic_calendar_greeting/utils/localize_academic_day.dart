import 'package:flutter/material.dart';

import '../../../utils/context_extensions.dart';
import '../model/academic_day.dart';
import '../model/weekday_enum.dart';

extension LocalizeAcademicDay on AcademicDay {
  String localize(BuildContext context) {
    if (isHolidays) return weekday.localizeHoliday(context);
    if (isExamSession) return weekday.localizeExamSession(context);
    return isEven
        ? weekday.localizeEven(context)
        : weekday.localizeOdd(context);
  }
}

extension LocalizeWeekDay on WeekdayEnum {
  String localizeEven(BuildContext context) {
    return switch (this) {
      WeekdayEnum.mon => context.localize.even_monday,
      WeekdayEnum.tue => context.localize.even_tuesday,
      WeekdayEnum.wed => context.localize.even_wednesday,
      WeekdayEnum.thu => context.localize.even_thursday,
      WeekdayEnum.fri => context.localize.even_friday,
      WeekdayEnum.sat => context.localize.even_saturday,
      WeekdayEnum.sun => context.localize.even_sunday,
    };
  }

  String localizeOdd(BuildContext context) {
    return switch (this) {
      WeekdayEnum.mon => context.localize.odd_monday,
      WeekdayEnum.tue => context.localize.odd_tuesday,
      WeekdayEnum.wed => context.localize.odd_wednesday,
      WeekdayEnum.thu => context.localize.odd_thursday,
      WeekdayEnum.fri => context.localize.odd_friday,
      WeekdayEnum.sat => context.localize.odd_saturday,
      WeekdayEnum.sun => context.localize.odd_sunday,
    };
  }

  String localizeHoliday(BuildContext context) {
    return switch (this) {
      WeekdayEnum.mon => context.localize.holiday_monday,
      WeekdayEnum.tue => context.localize.holiday_tuesday,
      WeekdayEnum.wed => context.localize.holiday_wednesday,
      WeekdayEnum.thu => context.localize.holiday_thursday,
      WeekdayEnum.fri => context.localize.holiday_friday,
      WeekdayEnum.sat => context.localize.holiday_saturday,
      WeekdayEnum.sun => context.localize.holiday_sunday,
    };
  }

  String localizeExamSession(BuildContext context) {
    return switch (this) {
      WeekdayEnum.mon => context.localize.exam_monday,
      WeekdayEnum.tue => context.localize.exam_tuesday,
      WeekdayEnum.wed => context.localize.exam_wednesday,
      WeekdayEnum.thu => context.localize.exam_thursday,
      WeekdayEnum.fri => context.localize.exam_friday,
      WeekdayEnum.sat => context.localize.exam_saturday,
      WeekdayEnum.sun => context.localize.exam_sunday,
    };
  }
}

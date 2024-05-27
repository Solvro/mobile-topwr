import 'package:flutter/material.dart';

import '../../../utils/context_extensions.dart';
import '../model/academic_day.dart';
import '../model/weekday_enum.dart';

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
}

extension LocalizeAcademicDay on AcademicDay {
  String localize(BuildContext context) {
    return isEven
        ? weekday.localizeEven(context)
        : weekday.localizeOdd(context);
  }
}

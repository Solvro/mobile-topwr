import 'package:flutter/material.dart';

import '../../../utils/context_extensions.dart';
import '../model/academic_day.dart';
import '../model/weekday_enum.dart';

extension LocalizeWeekDay on WeekdayEnum {
  String localize(BuildContext context) {
    return switch (this) {
      WeekdayEnum.mon => context.localize.monday,
      WeekdayEnum.tue => context.localize.tuesday,
      WeekdayEnum.wed => context.localize.wednesday,
      WeekdayEnum.thu => context.localize.thursday,
      WeekdayEnum.fri => context.localize.friday,
      WeekdayEnum.sat => context.localize.saturday,
      WeekdayEnum.sun => context.localize.sunday,
    };
  }
}

extension LocalizeAcademicDay on AcademicDay {
  String localize(BuildContext context) {
    final prefix = isEven ? context.localize.even_f : context.localize.odd_f;
    return prefix + weekday.localize(context);
  }
}

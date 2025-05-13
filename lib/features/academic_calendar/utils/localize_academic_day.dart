import "package:flutter/material.dart";

import "../../../utils/context_extensions.dart";
import "../model/academic_day.dart";
import "../model/weekday_enum.dart";

extension LocalizeAcademicDayX on AcademicDay {
  String _localizeWithPrefix(BuildContext context) {
    if (isHolidays) return weekday.localizeHoliday(context);
    if (isExamSession) return weekday.localizeExamSession(context);
    return isEven ? weekday.localizeEven(context) : weekday.localizeOdd(context);
  }

  String _localizeDeclinedNoun(BuildContext context) {
    // TODO(simon-the-shark): decline holiday and exam session days (but they shouldn't be used in this context anyway)
    if (isHolidays) return weekday.localizeHoliday(context);
    if (isExamSession) return weekday.localizeExamSession(context);
    return isEven
        ? switch (weekday) {
          WeekdayEnum.mon => context.localize.even_monday_declined,
          WeekdayEnum.tue => context.localize.even_tuesday_declined,
          WeekdayEnum.wed => context.localize.even_wednesday_declined,
          WeekdayEnum.thu => context.localize.even_thursday_declined,
          WeekdayEnum.fri => context.localize.even_friday_declined,
          WeekdayEnum.sat => context.localize.even_saturday_declined,
          WeekdayEnum.sun => context.localize.even_sunday_declined,
        }
        : switch (weekday) {
          WeekdayEnum.mon => context.localize.odd_monday_declined,
          WeekdayEnum.tue => context.localize.odd_tuesday_declined,
          WeekdayEnum.wed => context.localize.odd_wednesday_declined,
          WeekdayEnum.thu => context.localize.odd_thursday_declined,
          WeekdayEnum.fri => context.localize.odd_friday_declined,
          WeekdayEnum.sat => context.localize.odd_saturday_declined,
          WeekdayEnum.sun => context.localize.odd_sunday_declined,
        };
  }

  String localize(BuildContext context, {bool includePrefix = true, bool getDeclinedNoun = false}) {
    if (getDeclinedNoun) {
      return _localizeDeclinedNoun(context);
    }
    final withPrefix = _localizeWithPrefix(context);
    if (!includePrefix) return withPrefix.split(" ").skip(1).join(" ");
    return withPrefix;
  }
}

extension LocalizeWeekDayX on WeekdayEnum {
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

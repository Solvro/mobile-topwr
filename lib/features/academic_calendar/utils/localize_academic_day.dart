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
          WeekdayEnum.monday => context.localize.even_monday_declined,
          WeekdayEnum.tuesday => context.localize.even_tuesday_declined,
          WeekdayEnum.wednesday => context.localize.even_wednesday_declined,
          WeekdayEnum.thursday => context.localize.even_thursday_declined,
          WeekdayEnum.friday => context.localize.even_friday_declined,
          WeekdayEnum.saturday => context.localize.even_saturday_declined,
          WeekdayEnum.sunday => context.localize.even_sunday_declined,
        }
        : switch (weekday) {
          WeekdayEnum.monday => context.localize.odd_monday_declined,
          WeekdayEnum.tuesday => context.localize.odd_tuesday_declined,
          WeekdayEnum.wednesday => context.localize.odd_wednesday_declined,
          WeekdayEnum.thursday => context.localize.odd_thursday_declined,
          WeekdayEnum.friday => context.localize.odd_friday_declined,
          WeekdayEnum.saturday => context.localize.odd_saturday_declined,
          WeekdayEnum.sunday => context.localize.odd_sunday_declined,
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
      WeekdayEnum.monday => context.localize.even_monday,
      WeekdayEnum.tuesday => context.localize.even_tuesday,
      WeekdayEnum.wednesday => context.localize.even_wednesday,
      WeekdayEnum.thursday => context.localize.even_thursday,
      WeekdayEnum.friday => context.localize.even_friday,
      WeekdayEnum.saturday => context.localize.even_saturday,
      WeekdayEnum.sunday => context.localize.even_sunday,
    };
  }

  String localizeOdd(BuildContext context) {
    return switch (this) {
      WeekdayEnum.monday => context.localize.odd_monday,
      WeekdayEnum.tuesday => context.localize.odd_tuesday,
      WeekdayEnum.wednesday => context.localize.odd_wednesday,
      WeekdayEnum.thursday => context.localize.odd_thursday,
      WeekdayEnum.friday => context.localize.odd_friday,
      WeekdayEnum.saturday => context.localize.odd_saturday,
      WeekdayEnum.sunday => context.localize.odd_sunday,
    };
  }

  String localizeHoliday(BuildContext context) {
    return switch (this) {
      WeekdayEnum.monday => context.localize.holiday_monday,
      WeekdayEnum.tuesday => context.localize.holiday_tuesday,
      WeekdayEnum.wednesday => context.localize.holiday_wednesday,
      WeekdayEnum.thursday => context.localize.holiday_thursday,
      WeekdayEnum.friday => context.localize.holiday_friday,
      WeekdayEnum.saturday => context.localize.holiday_saturday,
      WeekdayEnum.sunday => context.localize.holiday_sunday,
    };
  }

  String localizeExamSession(BuildContext context) {
    return switch (this) {
      WeekdayEnum.monday => context.localize.exam_monday,
      WeekdayEnum.tuesday => context.localize.exam_tuesday,
      WeekdayEnum.wednesday => context.localize.exam_wednesday,
      WeekdayEnum.thursday => context.localize.exam_thursday,
      WeekdayEnum.friday => context.localize.exam_friday,
      WeekdayEnum.saturday => context.localize.exam_saturday,
      WeekdayEnum.sunday => context.localize.exam_sunday,
    };
  }
}

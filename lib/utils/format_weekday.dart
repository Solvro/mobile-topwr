import 'package:flutter/material.dart';
import '../features/home_view/repositories/week_parity_exceptions_repository/get_week_parity_exceptions_repository.dart';
import 'context_extensions.dart';
import 'enum_weekday_extensions.dart';
import 'same_date.dart';

extension FormatWeekdayExtension on BuildContext {
  String mapAcademicScheduleDay(
      DateTime date, List<WeekParityExceptions?>? value) {

    final exceptionIndex =
        value?.indexWhere((element) => element?.date.isSameDay(date) ?? false) ?? -1;

    final isEven = exceptionIndex != -1
        ? (value![exceptionIndex]?.parity.isEven ?? date.day.isEven)
        : date.day.isEven;
    final weekday = exceptionIndex != -1
        ? (value![exceptionIndex]?.dayOfTheWeek.toDateTimeWeekday ?? date.weekday)
        : date.weekday;

    return switch (weekday) {
      DateTime.sunday => isEven
          ? "${localize.even_f} ${localize.sunday}"
          : "${localize.odd_f} ${localize.sunday}",
      DateTime.monday => isEven
          ? "${localize.even} ${localize.monday}"
          : "${localize.odd} ${localize.monday}",
      DateTime.tuesday => isEven
          ? "${localize.even} ${localize.tuesday}"
          : "${localize.odd} ${localize.tuesday}",
      DateTime.wednesday => isEven
          ? "${localize.even_f} ${localize.wednesday}"
          : "${localize.odd_f} ${localize.wednesday}",
      DateTime.thursday => isEven
          ? "${localize.even} ${localize.thursday}"
          : "${localize.odd} ${localize.thursday}",
      DateTime.friday => isEven
          ? "${localize.even} ${localize.friday}"
          : "${localize.odd} ${localize.friday}",
      DateTime.saturday => isEven
          ? "${localize.even_f} ${localize.saturday}"
          : "${localize.odd_f} ${localize.saturday}",
      _ => localize.unknown_day,
    };
  }
}





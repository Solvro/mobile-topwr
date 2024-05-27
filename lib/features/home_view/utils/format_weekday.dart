import 'package:flutter/material.dart';

import '../../../utils/context_extensions.dart';
import '../repositories/week_parity_exceptions_repository/get_week_parity_exceptions_repository.dart';

extension FormatWeekdayExtension on BuildContext {
  String mapAcademicScheduleDay(
      DateTime date, List<WeekParityExceptions?>? value) {
    // final exception = value.findException(date);
    final isEven = false;
    final weekday = DateTime.monday;
    // final isEven = exception?.parity.isEven ?? date.day.isEven;
    // final weekday = exception?.dayOfTheWeek.toDateTimeWeekday ?? date.weekday;

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

// extension FindExceptionExtension on List<WeekParityExceptions?>? {
//   WeekParityExceptions? findException(DateTime date) {
//     final index =
//         this?.indexWhere((element) => element?.date.isSameDay(date) ?? false) ??
//             -1;
//     if (index == -1) return null;
//     return this![index];
//   }
// }

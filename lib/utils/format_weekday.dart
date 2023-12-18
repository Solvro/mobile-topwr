import 'package:flutter/material.dart';
import 'context_extensions.dart';

extension FormatWeekdayExtension on BuildContext {
  String mapAcademicScheduleDay(DateTime date) {

      final isEven = date.day.isEven;
      return switch (date.weekday) {
        DateTime.sunday => isEven
            ? "${localize?.even_f} ${localize?.sunday}"
            : "${localize?.odd_f} ${localize?.sunday}",
        DateTime.monday => isEven
            ? "${localize?.even} ${localize?.monday}"
            : "${localize?.odd} ${localize?.monday}",
        DateTime.tuesday => isEven
            ? "${localize?.even} ${localize?.tuesday}"
            : "${localize?.odd} ${localize?.tuesday}",
        DateTime.wednesday => isEven
            ? "${localize?.even_f} ${localize?.wednesday}"
            : "${localize?.odd_f} ${localize?.wednesday}",
        DateTime.thursday => isEven
            ? "${localize?.even} ${localize?.thursday}"
            : "${localize?.odd} ${localize?.thursday}",
        DateTime.friday => isEven
            ? "${localize?.even} ${localize?.friday}"
            : "${localize?.odd} ${localize?.friday}",
        DateTime.saturday => isEven
            ? "${localize?.even_f} ${localize?.saturday}"
            : "${localize?.odd_f} ${localize?.saturday}",
        _ => localize!.unknown_day,
      };
    }
}

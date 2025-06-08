import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "context_extensions.dart";

DateTime get now => DateTime.now();

/// like [now] but without time
DateTime get today => DateTime(now.year, now.month, now.day);

extension DateTimeUtilsX on DateTime {
  DateTime findMondayOfTheWeek() {
    final difference = weekday - DateTime.monday;
    return subtract(Duration(days: difference));
  }

  String toDayDateString(BuildContext context, {bool includeWeekday = true, bool includeYear = true}) {
    final dayFormat = DateFormat("EEEE", context.locale.languageCode);
    final dateFormat =
        includeYear
            ? DateFormat("dd.MM.yyyy", context.locale.languageCode)
            : DateFormat("dd.MM", context.locale.languageCode);
    final day = dayFormat.format(this);
    final capitalizedDay = day[0].toUpperCase() + day.substring(1).toLowerCase();
    final date = dateFormat.format(this);
    if (includeWeekday) {
      return "$capitalizedDay, $date";
    }
    return date;
  }

  String toHourMinuteString(BuildContext context) {
    final hourFormat = DateFormat("HH:mm", context.locale.languageCode);
    return hourFormat.format(this);
  }

  // Convert DateTime to Date (remove time)
  DateTime get date => DateTime(year, month, day);

  int calculateWeeksTo(DateTime end) {
    final difference = end.difference(this);
    return (difference.inDays / 7).floor();
  }

  int get daysLeftFromNow => difference(DateTime.now()).inDays;

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isBeforeOrSameAs(DateTime other) {
    return isBefore(other) || isAtSameMomentAs(other);
  }

  bool isAfterOrSameAs(DateTime other) {
    return isAfter(other) || isAtSameMomentAs(other);
  }
}

DateTime fromJsonToLocalTime(String dataTimeString) {
  return DateTime.parse(dataTimeString).toLocal();
}

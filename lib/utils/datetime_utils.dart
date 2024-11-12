import "package:intl/intl.dart";

DateTime get now => DateTime.now();

extension DateTimeUtilsX on DateTime {
  DateTime findMondayOfTheWeek() {
    final difference = weekday - DateTime.monday;
    return subtract(Duration(days: difference));
  }

  String toDayDateString() {
    final DateFormat dayFormat = DateFormat("EEEE", "pl_PL");
    final DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    final String day = dayFormat.format(this);
    final String capitalizedDay =
        day[0].toUpperCase() + day.substring(1).toLowerCase();
    final String date = dateFormat.format(this);
    return "$capitalizedDay, $date";
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

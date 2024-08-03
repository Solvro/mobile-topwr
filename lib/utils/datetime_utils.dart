DateTime get now => DateTime.now();

extension DateTimeUtils on DateTime {
  DateTime findMondayOfTheWeek() {
    final difference = weekday - DateTime.monday;
    return subtract(Duration(days: difference));
  }

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

extension FindMonday on DateTime {
  DateTime findMondayOfTheWeek() {
    final difference = weekday - DateTime.monday;
    return subtract(Duration(days: difference));
  }

  int calculateWeeksTo(DateTime end) {
    final difference = end.difference(this);
    return (difference.inDays / 7).floor();
  }
}

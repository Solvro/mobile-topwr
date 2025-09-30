import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/repository/calendar_repository.dart";
import "models.dart";

part "get_events_per_days_use_case.g.dart";

@riverpod
Future<IList<CalendarYearEvents>> getEventsPerDaysUseCase(Ref ref) async {
  final events = await ref.watch(calendarRepositoryProvider.future);

  // Group events by year, month, and day
  final Map<int, Map<int, Map<int, List<SingleCalendarItem>>>> groupedEvents = {};

  for (final event in events) {
    final startDate = DateTime.parse(event.startTime);
    final endDate = DateTime.parse(event.endTime);

    // Create a list of all days this event spans
    final days = <DateTime>[];
    var currentDate = DateTime(startDate.year, startDate.month, startDate.day);
    final endDay = DateTime(endDate.year, endDate.month, endDate.day);

    while (!currentDate.isAfter(endDay)) {
      days.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    // Add the event to each day it spans
    for (var i = 0; i < days.length; i++) {
      final day = days[i];
      final year = day.year;
      final month = day.month;
      final dayOfMonth = day.day;

      // Create the calendar item with appropriate time format
      final calendarItem = (
        name: event.name,
        location: event.location ?? "",
        hoursString: days.length == 1 ? _formatTimeRange(startDate, endDate) : "dzień ${i + 1}/${days.length}",
      );

      groupedEvents[year] ??= {};
      groupedEvents[year]![month] ??= {};
      groupedEvents[year]![month]![dayOfMonth] ??= [];
      groupedEvents[year]![month]![dayOfMonth]!.add(calendarItem);
    }
  }

  // Convert to the nested structure
  final result = <CalendarYearEvents>[];

  for (final yearEntry in groupedEvents.entries) {
    final year = yearEntry.key;
    final months = <CalendarMonthEvents>[];

    for (final monthEntry in yearEntry.value.entries) {
      final month = monthEntry.key;
      final days = <CalendarDayEvents>[];

      for (final dayEntry in monthEntry.value.entries) {
        final day = dayEntry.key;
        final events = dayEntry.value.toIList();
        final dayDateTime = DateTime(year, month, day);

        days.add((day: day, events: events, weekday: dayDateTime.weekday));
      }

      // Sort days within the month
      days.sort((a, b) => a.day.compareTo(b.day));

      months.add((month: month, events: days.toIList()));
    }

    // Sort months within the year
    months.sort((a, b) => a.month.compareTo(b.month));

    result.add((year: year, events: months.toIList()));
  }

  // Sort years
  result.sort((a, b) => a.year.compareTo(b.year));

  return result.toIList();
}

String _formatTimeRange(DateTime start, DateTime end) {
  final startTime = '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
  final endTime = '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
  return "$startTime - $endTime";
}

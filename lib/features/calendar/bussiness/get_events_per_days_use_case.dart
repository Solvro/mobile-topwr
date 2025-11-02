import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../l10n/app_localizations.dart";
import "../../../theme/hex_color.dart";
import "../../../utils/watch_locale.dart";
import "../data/model/calendar_data.dart";
import "../data/repository/calendar_repository.dart";
import "../presentation/calendar_search_controller.dart";
import "models.dart";

part "get_events_per_days_use_case.g.dart";

@riverpod
Future<IList<CalendarYearEvents>> getEventsPerDaysUseCase(Ref ref) async {
  final query = ref.watch(searchCalendarControllerProvider);
  final events = await ref.watch(calendarRepositoryProvider(query).future);
  final l10n = ref.watch(watchLocaleProvider);
  return groupEventsByYear(events, l10n);
}

/// Groups calendar events by year and returns sorted year events
IList<CalendarYearEvents> groupEventsByYear(IList<CalendarData> events, AppLocalizations l10n) {
  // Generate all event-day combinations
  final eventDays = events.expand((event) => _generateEventDays(event, l10n)).toList();

  // Group by year, then month, then day using collection utilities
  final groupedByYear = groupBy(eventDays, (eventDay) => eventDay.date.year);

  return groupedByYear.entries
      .map((yearEntry) => _buildYearEvents(yearEntry.key, yearEntry.value))
      .sorted((a, b) => a.year.compareTo(b.year))
      .toIList();
}

/// Generates a range of dates from start to end (inclusive)
Iterable<DateTime> _generateDateRange(DateTime start, DateTime end) sync* {
  var current = start;
  while (!current.isAfter(end)) {
    yield current;
    current = current.add(const Duration(days: 1));
  }
}

/// Generates all days an event spans with appropriate calendar items
List<({DateTime date, SingleCalendarItem item})> _generateEventDays(CalendarData event, AppLocalizations l10n) {
  final startDate = DateTime.parse(event.startTime);
  final endDate = DateTime.parse(event.endTime);

  final startDay = DateTime(startDate.year, startDate.month, startDate.day);
  final endDay = DateTime(endDate.year, endDate.month, endDate.day);

  return _generateDateRange(
    startDay,
    endDay,
  ).map((date) => (date: date, item: _createCalendarItem(event, startDate, endDate, date, l10n))).toList();
}

/// Creates a calendar item for a specific day
SingleCalendarItem _createCalendarItem(
  CalendarData event,
  DateTime startDate,
  DateTime endDate,
  DateTime dayDate,
  AppLocalizations l10n,
) {
  final isSingleDay =
      startDate.year == endDate.year && startDate.month == endDate.month && startDate.day == endDate.day;

  final totalDays = _generateDateRange(
    DateTime(startDate.year, startDate.month, startDate.day),
    DateTime(endDate.year, endDate.month, endDate.day),
  ).length;

  final dayNumber = _generateDateRange(DateTime(startDate.year, startDate.month, startDate.day), dayDate).length;

  final hoursString = isSingleDay ? _formatTimeRange(startDate, endDate) : "${l10n.day} $dayNumber/$totalDays";

  return (
    name: event.name,
    location: event.location ?? "",
    hoursString: hoursString,
    description: event.description,
    accentColor: event.accentColor != null ? HexColor(event.accentColor!) : null,
  );
}

/// Builds year events from grouped event days
CalendarYearEvents _buildYearEvents(int year, List<({DateTime date, SingleCalendarItem item})> eventDays) {
  final groupedByMonth = groupBy(eventDays, (eventDay) => eventDay.date.month);

  final months = groupedByMonth.entries
      .map((monthEntry) => _buildMonthEvents(monthEntry.key, monthEntry.value))
      .sorted((a, b) => a.month.compareTo(b.month))
      .toIList();

  return (year: year, events: months);
}

/// Builds month events from grouped event days
CalendarMonthEvents _buildMonthEvents(int month, List<({DateTime date, SingleCalendarItem item})> eventDays) {
  final groupedByDay = groupBy(eventDays, (eventDay) => eventDay.date.day);

  final days = groupedByDay.entries
      .map((dayEntry) => _buildDayEvents(dayEntry.key, dayEntry.value))
      .sorted((a, b) => a.day.compareTo(b.day))
      .toIList();

  return (month: month, events: days);
}

/// Builds day events from grouped event days
CalendarDayEvents _buildDayEvents(int day, List<({DateTime date, SingleCalendarItem item})> eventDays) {
  final events = eventDays.map((eventDay) => eventDay.item).toIList();
  final firstEvent = eventDays.first;
  return (day: day, events: events, weekday: firstEvent.date.weekday);
}

String _formatTimeRange(DateTime start, DateTime end) {
  final startTime = '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
  final endTime = '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
  return "$startTime - $endTime";
}

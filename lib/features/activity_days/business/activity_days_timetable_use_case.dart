import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../calendar/bussiness/models.dart";
import "../data/models/activity_days_response.dart";
import "../data/repository/activity_days_repository.dart";

part "activity_days_timetable_use_case.g.dart";

typedef TimetableDay = ({DateTime date, IList<SingleCalendarItem> events});

@riverpod
Future<IList<TimetableDay>> activityDaysTimetableUseCase(Ref ref) async {
  final event = await ref.watch(activityDaysRepositoryProvider.future);
  final entries = event?.timetable?.entries ?? const IListConst([]);
  if (entries.isEmpty) return const IListConst([]);

  final grouped = groupBy(
    entries.unlock,
    (ActivityDaysTimetableEntry entry) => DateTime(entry.startTime.year, entry.startTime.month, entry.startTime.day),
  );

  return grouped.entries
      .map(
        (dayEntry) => (
          date: dayEntry.key,
          events: dayEntry.value
              .sorted((a, b) => a.startTime.compareTo(b.startTime))
              .map(_toCalendarItem)
              .toIList(),
        ),
      )
      .sorted((a, b) => a.date.compareTo(b.date))
      .toIList();
}

SingleCalendarItem _toCalendarItem(ActivityDaysTimetableEntry entry) {
  return (
    name: entry.name,
    location: "",
    hoursString: _formatHours(entry.startTime, entry.endTime),
    description: null,
    accentColor: null,
  );
}

String _formatHours(DateTime start, DateTime? end) {
  String hm(DateTime time) => "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
  return end != null ? "${hm(start)} – ${hm(end)}" : hm(start);
}
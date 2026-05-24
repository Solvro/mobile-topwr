// ignore_for_file: dead_code, literal_only_boolean_expressions
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../models/activity_days_response.dart";

part "activity_days_repository.g.dart";

@riverpod
Future<ActivityDaysResponse?> activityDaysRepository(Ref ref) async {
  final now = DateTime.now();
  if (true) {
    return ActivityDaysResponse(
      id: 999,
      name: "Wiosenne Dni Aktywności Studenckiej",
      startsAt: now.subtract(const Duration(days: 1)),
      endsAt: now.add(const Duration(days: 2)),
      createdAt: now.subtract(const Duration(days: 30)),
      updatedAt: now.subtract(const Duration(days: 5)),
      timetable: const ActivityDaysTimetable(id: 1, description: "Harmonogram DAS"),
      maps: const IListConst([ActivityDaysMap(id: 1, name: "Mapa główna")]),
      links: const IListConst([ActivityDaysLink(id: 1, url: "https://pwr.edu.pl")]),
      stands: const IListConst([
        ActivityDaysStand(id: 1, name: "Koło Naukowe Solvro"),
        ActivityDaysStand(id: 2, name: "PWR Racing Team"),
      ]),
    );
  }

  final url = "${Env.mainRestApiUrl}/das";

  final response = await ref.getAndCacheData(
    url,
    ActivityDaysResponse.fromJson,
    extraValidityCheck: (_) => true,
    onRetry: ref.invalidateSelf,
  );
  final events = response.castAsList;
  if (events.isEmpty) return null;

  final runningEvents = events.where((e) => now.isAfter(e.startsAt) && now.isBefore(e.endsAt));
  if (runningEvents.isNotEmpty) {
    return runningEvents.first;
  }

  final upcomingEvents = events.where((e) => e.startsAt.isAfter(now)).toList()
    ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
  if (upcomingEvents.isNotEmpty) {
    return upcomingEvents.first;
  }

  return null;
}

@riverpod
Future<bool> isActivityDaysActive(Ref ref) async {
  final event = await ref.watch(activityDaysRepositoryProvider.future);
  if (event == null) return false;

  final now = DateTime.now();
  return now.isAfter(event.startsAt) && now.isBefore(event.endsAt);
}

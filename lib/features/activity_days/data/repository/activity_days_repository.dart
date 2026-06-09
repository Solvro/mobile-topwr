// ignore_for_file: dead_code, literal_only_boolean_expressions
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../../../feature_codes/data/feature_codes_repository.dart";
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
      timetable: ActivityDaysTimetable(
        id: 1,
        description: "Harmonogram DAS",
        entries: [
          ActivityDaysTimetableEntry(
            id: 1,
            name: "Entry 1",
            startTime: now.add(const Duration(hours: 2)),
            // endTime: now.add(const Duration(hours: 3)),
          ),
          ActivityDaysTimetableEntry(
            id: 2,
            name: "Entry 2",
            startTime: now.add(const Duration(hours: 4)),
            endTime: now.add(const Duration(hours: 6)),
          ),
          ActivityDaysTimetableEntry(
            id: 3,
            name: "Entry 3",
            startTime: now.add(const Duration(days: 1, hours: 2)),
            endTime: now.add(const Duration(days: 1, hours: 4)),
          ),
        ].lock,
      ),
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
    ActivityDaysListResponse.fromJson,
    extraValidityCheck: (_) => true,
    onRetry: ref.invalidateSelf,
  );
  final events = response.castAsObject.data;
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
  final featureCodes = ref.watch(featureCodesRepositoryProvider);
  if (!featureCodes.contains(Env.activityDaysFeatureCode)) return false;

  final event = await ref.watch(activityDaysRepositoryProvider.future);
  if (event == null) return false;

  final now = DateTime.now();
  return now.isAfter(event.startsAt) && now.isBefore(event.endsAt);
}

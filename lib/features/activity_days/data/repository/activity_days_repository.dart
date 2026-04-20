import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/activity_days_response.dart";

part "activity_days_repository.g.dart";

@riverpod
Future<ActivityDaysResponse?> activityDaysRepository(Ref ref) async {
  final restClient = ref.watch(restClientProvider);
  final url = "${Env.mainRestApiUrl}/das";

  try {
    final response = await restClient.get<List<dynamic>>(url);
    final data = response.data;
    if (data == null || data.isEmpty) return null;

    final now = DateTime.now();
    final events = data
        .whereType<Map<String, dynamic>>()
        .map(ActivityDaysResponse.fromJson)
        .toList();

    // 1. Currently running event (now is between startsAt and endsAt)
    final runningEvents = events.where(
      (e) => now.isAfter(e.startsAt) && now.isBefore(e.endsAt),
    );
    if (runningEvents.isNotEmpty) {
      return runningEvents.first;
    }

    // 2. Closest upcoming event (startsAt is in the future)
    final upcomingEvents = events
        .where((e) => e.startsAt.isAfter(now))
        .toList()
      ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    if (upcomingEvents.isNotEmpty) {
      return upcomingEvents.first;
    }

    // 3. No active or upcoming events
    return null;
  } on DioException {
    return null;
  }
}

/// Provider that determines whether the Activity Days button should be visible.
/// Returns true only when there is a currently running event.
@riverpod
Future<bool> isActivityDaysActive(Ref ref) async {
  final event = await ref.watch(activityDaysRepositoryProvider.future);
  if (event == null) return false;

  final now = DateTime.now();
  return now.isAfter(event.startsAt) && now.isBefore(event.endsAt);
}

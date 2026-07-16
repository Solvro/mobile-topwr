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
  final url = "${Env.mainRestApiUrl}/das";

  final response = await ref.getAndCacheData(
    url,
    ActivityDaysListResponse.fromJson,
    extraValidityCheck: (response) => response.castAsObject.data.any((event) => event.endsAt.isAfter(DateTime.now())),
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

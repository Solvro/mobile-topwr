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
  final hasPreviewAccess = ref.watch(featureCodesRepositoryProvider).contains(Env.activityDaysFeatureCode);
  final url = "${Env.mainRestApiUrl}/das?maps=true&links=true&maps.image=true";

  final response = await ref.getAndCacheData(
    url,
    ActivityDaysListResponse.fromJson,
    extraValidityCheck: (response) => response.castAsObject.data.any((event) => event.endsAt.isAfter(DateTime.now())),
    onRetry: ref.invalidateSelf,
  );
  return selectActivityDaysEvent(response.castAsObject.data, now: now, includeExpired: hasPreviewAccess);
}

@riverpod
Future<bool> isActivityDaysActive(Ref ref) async {
  final featureCodes = ref.watch(featureCodesRepositoryProvider);
  final event = await ref.watch(activityDaysRepositoryProvider.future);
  if (event == null) return false;

  if (featureCodes.contains(Env.activityDaysFeatureCode)) return true;

  final now = DateTime.now();
  return now.isAfter(event.startsAt) && now.isBefore(event.endsAt);
}

ActivityDaysResponse? selectActivityDaysEvent(
  Iterable<ActivityDaysResponse> events, {
  required DateTime now,
  required bool includeExpired,
}) {
  final eventList = events.toIList();
  if (eventList.isEmpty) return null;

  final runningEvents = eventList.where((event) => now.isAfter(event.startsAt) && now.isBefore(event.endsAt));
  if (runningEvents.isNotEmpty) return runningEvents.first;

  final upcomingEvents = eventList
      .where((event) => event.startsAt.isAfter(now))
      .toIList()
      .sort((a, b) => a.startsAt.compareTo(b.startsAt));
  if (upcomingEvents.isNotEmpty) return upcomingEvents.first;

  if (!includeExpired) return null;

  return eventList.sort((a, b) => b.endsAt.compareTo(a.endsAt)).first;
}

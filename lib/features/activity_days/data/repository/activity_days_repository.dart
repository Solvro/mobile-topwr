import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../../config/env.dart";
import "../../../feature_codes/data/feature_codes_repository.dart";
import "../models/activity_days_response.dart";

part "activity_days_repository.g.dart";

@riverpod
Future<ActivityDaysResponse?> activityDaysRepository(Ref ref) async {
  final now = DateTime.now();
  final url = "${Env.mainRestApiUrl}/das?maps=true&links=true&maps.image=true";

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
    return _hydrateMapImages(ref, runningEvents.first);
  }

  final upcomingEvents = events.where((e) => e.startsAt.isAfter(now)).toList()
    ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
  if (upcomingEvents.isNotEmpty) {
    return _hydrateMapImages(ref, upcomingEvents.first);
  }

  return null;
}

Future<ActivityDaysResponse> _hydrateMapImages(Ref ref, ActivityDaysResponse event) async {
  final maps = await Future.wait(
    event.maps.map((map) async {
      final contentKey = map.contentKey;
      if (map.image != null || contentKey == null || contentKey.isEmpty) return map;

      try {
        final response = await ref.getAndCacheData(
          "${Env.mainRestApiUrl}/files/$contentKey",
          ImageData.fromJson,
          extraValidityCheck: (_) => true,
        );
        return map.copyWith(image: response.castAsObject);
      } on Object {
        return map;
      }
    }),
  );
  return event.copyWith(maps: maps.toIList());
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

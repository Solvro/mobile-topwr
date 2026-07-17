import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../models/activity_days_response.dart";
import "../models/activity_days_timetable_response.dart";
import "activity_days_repository.dart";

part "activity_days_timetable_repository.g.dart";

@riverpod
Future<IList<ActivityDaysTimetableEntry>> activityDaysTimetableRepository(Ref ref) async {
  final event = await ref.watch(activityDaysRepositoryProvider.future);
  if (event == null) return const IListConst([]);

  final url = "${Env.mainRestApiUrl}/das_timetables/${event.id}?entries=true";
  final response = await ref.getAndCacheDataWithTranslation(
    url,
    ActivityDaysTimetableResponse.fromJson,
    extraValidityCheck: (_) => true,
    onRetry: ref.invalidateSelf,
  );
  return response.castAsObject.data.entries;
}

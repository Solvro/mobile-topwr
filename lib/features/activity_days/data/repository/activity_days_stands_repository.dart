import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../models/activity_days_stand_response.dart";
import "../models/activity_days_stands_response.dart";
import "activity_days_repository.dart";

part "activity_days_stands_repository.g.dart";

@riverpod
Future<IList<DasStand>> dasStandsRepository(Ref ref) async {
  final event = await ref.watch(activityDaysRepositoryProvider.future);
  if (event == null) return const IListConst([]);

  final url =
      "${Env.mainRestApiUrl}/das_stands?dasId=${event.id}&logo=true&floor=true&dasOrganization.studentOrganization=true";

  final response = await ref.getAndCacheDataWithTranslation(
    url,
    DasStandsListResponse.fromJson,
    extraValidityCheck: (_) => true,
    onRetry: ref.invalidateSelf,
  );
  return response.castAsObject.data;
}

@riverpod
Future<DasStand> dasStandRepository(Ref ref, int id) async {
  final url = "${Env.mainRestApiUrl}/das_stands/$id?logo=true&floor=true&dasOrganization.studentOrganization=true";

  final response = await ref.getAndCacheDataWithTranslation(
    url,
    DasStandResponse.fromJson,
    extraValidityCheck: (_) => true,
    onRetry: ref.invalidateSelf,
  );
  return response.castAsObject.data;
}

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../models/activity_days_stands_response.dart";

part "activity_days_stands_repository.g.dart";

@riverpod
Future<IList<DasStand>> dasStandsRepository(Ref ref) async {
  final url = "${Env.mainRestApiUrl}/das_stands";

  final response = await ref.getAndCacheData(
    url,
    DasStandsListResponse.fromJson,
    extraValidityCheck: (_) => true,
    onRetry: ref.invalidateSelf,
  );
  return response.castAsObject.data;
}

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/railing.dart";

part "railings_repository.g.dart";

@riverpod
Future<Railing> railingsRepository(Ref ref, int railingID) {
  return ref
      .getAndCacheDataFromDigitalGuide("railings/$railingID", Railing.fromJson, onRetry: ref.invalidateSelf)
      .castAsObject;
}

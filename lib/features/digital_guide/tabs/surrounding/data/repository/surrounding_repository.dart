import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/digital_guide_response.dart";
import "../models/surrounding_response.dart";

part "surrounding_repository.g.dart";

@riverpod
Future<SurroundingResponse> surroundingRepository(Ref ref, DigitalGuideResponse digitalGuideData) {
  return ref
      .getAndCacheDataFromDigitalGuide(
        "surroundings/${digitalGuideData.surroundingId}",
        SurroundingResponse.fromJson,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;
}

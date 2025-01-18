import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/digital_guide_response.dart";
import "../models/digital_guide_transportation.dart";

part "transportation_repository.g.dart";

@riverpod
Future<TransportationResponse> transportationRepository(
    Ref ref,
    DigitalGuideResponse digitalGuideData,
    ) async {
  return ref.getAndCacheDataFromDigitalGuide(
    "transportation/${digitalGuideData.accessId}",
    TransportationResponse.fromJson,
    onRetry: () => ref.invalidateSelf(),
  );
}

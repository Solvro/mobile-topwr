import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../api/digital_guide_get_and_cache.dart";
import "../models/digital_guide_response.dart";

part "digital_guide_repository.g.dart";

@riverpod
Future<DigitalGuideResponse> digitalGuideRepository(
  Ref ref,
  int id,
) async {
  return ref.getAndCacheDataFromDigitalGuide(
    "buildings/$id",
    DigitalGuideResponse.fromJson,
    onRetry: () => ref.invalidateSelf(),
  );
}

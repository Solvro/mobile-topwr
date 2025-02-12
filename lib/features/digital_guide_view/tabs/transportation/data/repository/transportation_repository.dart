import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/digital_guide_response.dart";
import "../models/digital_guide_transportation.dart";

part "transportation_repository.g.dart";

@riverpod
Future<DigitalGuideTransportation> transportationRepository(
  Ref ref,
  DigitalGuideResponse building,
) async {
  const endpoint = "access/";

  final data = await ref.getAndCacheDataFromDigitalGuide(
    endpoint,
    (List<dynamic> json) => json
        .whereType<Map<String, dynamic>>()
        .map(DigitalGuideTransportation.fromJson)
        .toIList(),
    onRetry: () => ref.invalidateSelf(),
  );
  return data.firstWhere((data) => data.building == building.id);
}

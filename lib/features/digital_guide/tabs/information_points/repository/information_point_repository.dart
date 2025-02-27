import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../data/api/digital_guide_get_and_cache.dart";
import "../models/digital_guide_information_points.dart";

part "information_point_repository.g.dart";

@riverpod
Future<IList<DigitalGuideInformationPoint>?> informationPointRepository(
    Ref ref, int buildingId) async {
  final data = await ref.getAndCacheDataFromDigitalGuide(
    "information_points/?building=$buildingId",
    (List<dynamic> json) => json
        .whereType<Map<String, dynamic>>()
        .map(DigitalGuideInformationPoint.fromJson)
        .toIList(),
    onRetry: () => ref.invalidateSelf(),
  );

  if (data.isEmpty) return null;

  return data;
}

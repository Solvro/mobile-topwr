import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../buildings_view/repository/buildings_repository.dart";
import "../api/digital_guide_get_and_cache.dart";
import "../models/digital_guide_response.dart";

part "digital_guide_repository.g.dart";

@riverpod
Future<({DigitalGuideResponse digitalGuideData, String? photoUrl})> digitalGuideRepository(
  Ref ref,
  String ourId,
) async {
  final buildings = await ref.watch(buildingsRepositoryProvider.future);
  final building = buildings.firstWhere(
    (building) => building.id == ourId,
    orElse: () => throw Exception("No such building: $ourId"),
  );
  final digitalGuideId = building.externalDigitalGuideIdOrURL;
  debugPrint("before");
  final digitalGuideData = await ref.getAndCacheDataFromDigitalGuide(
    "buildings/$digitalGuideId",
    DigitalGuideResponse.fromJson,
    onRetry: () => ref.invalidateSelf(),
  );
  debugPrint("after");

  return (digitalGuideData: digitalGuideData, photoUrl: building.cover?.filename_disk);
}

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/level.dart";
import "../../../../data/models/level_with_regions.dart";
import "../../../../data/models/region.dart";
import "../models/digital_guide_lift.dart";

part "lifts_repository.g.dart";

@riverpod
Future<IList<DigitalGuideLift>> liftsRepository(
  Ref ref,
  LevelWithRegions level,
) async {
  Future<DigitalGuideLift> getDigitalGuideLift(int liftId) async {
    final endpoint = "lifts/$liftId";
    return ref.getAndCacheDataFromDigitalGuide(
      endpoint,
      DigitalGuideLift.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final liftsIds = level.regions.expand((region) => region.liftsIds);
  final lifts = await Future.wait(liftsIds.map(getDigitalGuideLift));
  return lifts.toIList();
}

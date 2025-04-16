import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/level.dart";
import "../../../../data/models/level_with_regions.dart";
import "../../../../data/models/region.dart";
import "../models/digital_guide_lift.dart";

part "lifts_repository.g.dart";

@riverpod
Future<IList<DigitalGuideLift>> liftsRepository(Ref ref, List<int> liftIDs) async {
  Future<DigitalGuideLift> getLift(int liftID) async {
    return ref
        .getAndCacheDataFromDigitalGuide("lifts/$liftID", DigitalGuideLift.fromJson, onRetry: ref.invalidateSelf)
        .castAsObject;
  }

  final lifts = await Future.wait(liftIDs.map(getLift));

  return lifts.lock;
}

@riverpod
Future<IList<DigitalGuideLift>> liftsFromLevelRepository(Ref ref, LevelWithRegions level) async {
  final liftsIds = level.regions.expand((region) => region.lifts).toList();
  return liftsRepository(ref, liftsIds);
}

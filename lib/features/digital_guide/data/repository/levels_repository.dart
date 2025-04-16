import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../api/digital_guide_get_and_cache.dart";
import "../models/digital_guide_response.dart";
import "../models/level.dart";
import "../models/level_with_regions.dart";
import "../models/region.dart";

part "levels_repository.g.dart";

@riverpod
Future<IList<Region>> regionsRepository(Ref ref, List<int> regionIDs) async {
  Future<Region> getRegion(int regionID) async {
    return ref
        .getAndCacheDataFromDigitalGuide("regions/$regionID", Region.fromJson, onRetry: ref.invalidateSelf)
        .castAsObject;
  }

  final regions = await Future.wait(regionIDs.map(getRegion));
  return regions.lock;
}

@riverpod
Future<IList<Level>> rawLevelsRepository(Ref ref, DigitalGuideResponse buildingData) async {
  Future<Level> getLevel(int levelID) async {
    return ref
        .getAndCacheDataFromDigitalGuide("levels/$levelID", Level.fromJson, onRetry: ref.invalidateSelf)
        .castAsObject;
  }

  final rawLevels = await Future.wait(buildingData.levelsIndices.map(getLevel));
  return rawLevels.lock;
}

@riverpod
Future<IList<LevelWithRegions>> levelsWithRegionsRepository(Ref ref, DigitalGuideResponse buildingData) async {
  final rawLevels = await ref.watch(rawLevelsRepositoryProvider(buildingData).future);
  Future<LevelWithRegions> expandLevelWithRegions(Level level) async {
    return (level: level, regions: await ref.watch(regionsRepositoryProvider(level.regionIndices).future));
  }

  final levels = await Future.wait(rawLevels.map(expandLevelWithRegions));
  return levels.lock.sort((level1, level2) => level1.level.floorNumber.compareTo(level2.level.floorNumber));
}

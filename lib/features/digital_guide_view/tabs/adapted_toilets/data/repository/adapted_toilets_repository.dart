import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/digital_guide_response.dart";
import "../../../../data/repository/levels_repository.dart";
import "../models/adapted_toilet.dart";

part "adapted_toilets_repository.g.dart";

@riverpod
Future<IMap<int, IList<AdaptedToilet>>> adaptedToiletsRepository(
  Ref ref,
  DigitalGuideResponse building,
) async {
  final Map<int, IList<AdaptedToilet>> adaptedToiletsMap = {};
  final levels =
      await ref.watch(levelsWithRegionsRepositoryProvider(building).future);

  Future<AdaptedToilet> getAdaptedToilet(int adaptedToiletID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "adapted_toilets/$adaptedToiletID",
      AdaptedToilet.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  for (final level in levels) {
    final adaptedToiletsIDs =
        level.regions.expand((region) => region.adaptedToiletsIndices);
    final adaptedToiletsList =
        await Future.wait(adaptedToiletsIDs.map(getAdaptedToilet));
    adaptedToiletsMap[level.level.id] = adaptedToiletsList.lock;
  }

  return adaptedToiletsMap.lock;
}

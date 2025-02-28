import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/stairway.dart";

part "stairways_repository.g.dart";

@riverpod
Future<IList<Stairway>> stairwaysRepository(Ref ref, List<int> stairwaysIDs) async {
  Future<Stairway> getStairway(int stairwayID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "stairways/$stairwayID",
      Stairway.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final stairways = await Future.wait(stairwaysIDs.map(getStairway));

  return stairways.lock;
}

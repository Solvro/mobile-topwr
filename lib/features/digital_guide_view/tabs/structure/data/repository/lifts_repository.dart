import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/lift.dart";

part "lifts_repository.g.dart";

@riverpod
Future<IList<Lift>> liftsRepository(
  Ref ref,
  List<int> liftIDs,
) async {
  Future<Lift> getLift(int liftID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "lifts/$liftID",
      Lift.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final lifts = await Future.wait(liftIDs.map(getLift));

  return lifts.lock;
}

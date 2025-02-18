import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/stairs.dart";

part "stairs_repository.g.dart";

@riverpod
Future<IList<Stairs>> stairsRepository(Ref ref, List<int> stairsIDs) async {
  Future<Stairs> getStairs(int stairsID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "stairs/$stairsID",
      Stairs.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final stairs = await Future.wait(stairsIDs.map(getStairs));

  return stairs.lock;
}

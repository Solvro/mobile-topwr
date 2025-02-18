import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../digital_guide/data/api/digital_guide_get_and_cache.dart";
import "../models/corridor.dart";

part "corridors_repository.g.dart";

@riverpod
Future<IList<Corridor>> corridorsRepository(
  Ref ref,
  List<int> corridorsIDs,
) async {
  Future<Corridor> getCorridor(int corridorID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "corridors/$corridorID",
      Corridor.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final corridors = await Future.wait(corridorsIDs.map(getCorridor));

  return corridors.lock;
}

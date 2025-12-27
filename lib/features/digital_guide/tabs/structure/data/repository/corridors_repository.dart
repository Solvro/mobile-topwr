import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/corridor.dart";

part "corridors_repository.g.dart";

@riverpod
Future<IList<Corridor>> corridorsRepository(Ref ref, List<int> corridorsIDs) async {
  Future<Corridor> getCorridor(int corridorID) {
    return ref
        .getAndCacheDataFromDigitalGuide("corridors/$corridorID", Corridor.fromJson, onRetry: ref.invalidateSelf)
        .castAsObject;
  }

  final corridors = await Future.wait(corridorsIDs.map(getCorridor));

  return corridors.lock;
}

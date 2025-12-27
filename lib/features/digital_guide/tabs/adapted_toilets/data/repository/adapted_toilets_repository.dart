import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/level_with_regions.dart";
import "../models/adapted_toilet.dart";

part "adapted_toilets_repository.g.dart";

@riverpod
Future<IList<AdaptedToilet>> adaptedToiletsRepository(Ref ref, LevelWithRegions level) async {
  Future<AdaptedToilet> getAdaptedToilet(int adaptedToiletID) {
    return ref
        .getAndCacheDataFromDigitalGuide(
          "adapted_toilets/$adaptedToiletID",
          AdaptedToilet.fromJson,
          onRetry: ref.invalidateSelf,
        )
        .castAsObject;
  }

  final adaptedToiletsIDs = level.regions.expand((region) => region.adaptedToilets);
  final toilets = await Future.wait(adaptedToiletsIDs.map(getAdaptedToilet));
  return toilets.toIList();
}

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/digital_guide_response.dart";
import "../models/digital_guide_lodge.dart";

part "lodges_repository.g.dart";

@riverpod
Future<IList<DigitalGuideLodge>> lodgesRepository(Ref ref, DigitalGuideResponse building) {
  final endpoint = "lodges/?building=${building.id}";
  return ref
      .getAndCacheDataFromDigitalGuide(endpoint, DigitalGuideLodge.fromJson, onRetry: ref.invalidateSelf)
      .castAsList;
}

@riverpod
Future<IList<DigitalGuideLodge>> lodgesFromIDsRepository(Ref ref, List<int> lodgesIDs) async {
  Future<DigitalGuideLodge> getLodge(int lodgeID) {
    return ref
        .getAndCacheDataFromDigitalGuide("lodges/$lodgeID", DigitalGuideLodge.fromJson, onRetry: ref.invalidateSelf)
        .castAsObject;
  }

  final lodges = await Future.wait(lodgesIDs.map(getLodge));

  return lodges.lock;
}

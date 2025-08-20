import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/digital_guide_response.dart";
import "../models/digital_guide_entrace.dart";

part "entraces_repository.g.dart";

@riverpod
Future<IList<DigitalGuideEntrace>> entrancesRepository(Ref ref, DigitalGuideResponse building) {
  return ref
      .getAndCacheDataFromDigitalGuide(
        "entrances/?building=${building.id}",
        DigitalGuideEntrace.fromJson,
        onRetry: () => ref.invalidateSelf(),
      )
      .castAsList;
}

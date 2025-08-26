import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../digital_guide/data/api/digital_guide_get_and_cache.dart";
import "../models/digital_guide_object_model.dart";
import "../models/digital_guide_object_tab_model.dart";

part "digital_guide_tabs_repository.g.dart";

@riverpod
Future<IList<DigitalGuideObjectTabResponse>> digitalGuideObjectTabsRepository(Ref ref, DigitalGuideObjectModel object) {
  final url = "objects_category?object=${object.id}";
  return ref
      .getAndCacheDataFromDigitalGuide(url, DigitalGuideObjectTabResponse.fromJson, onRetry: ref.invalidateSelf)
      .castAsList;
}

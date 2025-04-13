import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../../digital_guide/data/api/digital_guide_get_and_cache.dart";
import "../../../../../digital_guide/data/models/digital_guide_response.dart";
import "../models/digital_guide_transportation.dart";

part "transportation_repository.g.dart";

@riverpod
Future<DigitalGuideTransportation> transportationRepository(Ref ref, DigitalGuideResponse building) async {
  const endpoint = "access/";

  final data =
      await ref
          .getAndCacheDataFromDigitalGuide(endpoint, DigitalGuideTransportation.fromJson, onRetry: ref.invalidateSelf)
          .castAsList;
  return data.firstWhere((data) => data.building == building.id);
}

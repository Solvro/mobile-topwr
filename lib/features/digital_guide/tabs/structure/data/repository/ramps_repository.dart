import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/ramp.dart";

part "ramps_repository.g.dart";

@riverpod
Future<IList<Ramp>> rampsRepository(Ref ref, List<int> rampsIDs) async {
  Future<Ramp> getRamp(int rampID) {
    return ref
        .getAndCacheDataFromDigitalGuide("ramps/$rampID", Ramp.fromJson, onRetry: ref.invalidateSelf)
        .castAsObject;
  }

  final ramps = await Future.wait(rampsIDs.map(getRamp));

  return ramps.lock;
}

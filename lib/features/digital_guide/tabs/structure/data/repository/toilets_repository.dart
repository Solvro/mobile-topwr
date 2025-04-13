import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/toilet.dart";

part "toilets_repository.g.dart";

@riverpod
Future<IList<Toilet>> toiletsRepository(Ref ref, List<int> toiletsIDs) async {
  Future<Toilet> getToilet(int toiletID) async {
    return ref
        .getAndCacheDataFromDigitalGuide("toilets/$toiletID", Toilet.fromJson, onRetry: ref.invalidateSelf)
        .castAsObject;
  }

  final toilets = await Future.wait(toiletsIDs.map(getToilet));

  return toilets.lock;
}

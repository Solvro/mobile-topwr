import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/stairs.dart";

part "stairs_repository.g.dart";

@riverpod
Future<IList<Stairs>> stairsListRepository(Ref ref, List<int> stairsIDs) async {
  final stairs = await Future.wait(stairsIDs.map((id) => ref.watch(stairsRepositoryProvider(id).future)));
  return stairs.lock;
}

@riverpod
Future<Stairs> stairsRepository(Ref ref, int stairsID) async {
  return ref
      .getAndCacheDataFromDigitalGuide("stairs/$stairsID", Stairs.fromJson, onRetry: ref.invalidateSelf)
      .castAsObject;
}

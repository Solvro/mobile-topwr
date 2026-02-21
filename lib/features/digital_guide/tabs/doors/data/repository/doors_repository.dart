import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../model/door.dart";

part "doors_repository.g.dart";

@riverpod
Future<Door> doorsRepository(Ref ref, int doorsID) {
  return ref.getAndCacheDataFromDigitalGuide("doors/$doorsID", Door.fromJson, onRetry: ref.invalidateSelf).castAsObject;
}

@riverpod
Future<IList<Door>> doorsListRepository(Ref ref, List<int> ids) async {
  Future<Door> getDoor(int id) => ref.watch(doorsRepositoryProvider(id).future);
  final doors = await Future.wait(ids.map(getDoor));
  return doors.lock;
}

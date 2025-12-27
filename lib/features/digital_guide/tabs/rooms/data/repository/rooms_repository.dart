import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/level_with_regions.dart";
import "../models/digital_guide_room.dart";

part "rooms_repository.g.dart";

@riverpod
Future<IList<DigitalGuideRoom>> roomsByLevelRepository(Ref ref, LevelWithRegions level) async {
  final roomsIds = level.regions.expand((region) => region.rooms).toList();
  final rooms = await ref.read(roomsByIDsRepositoryProvider(roomsIds).future);
  return rooms;
}

@riverpod
Future<IList<DigitalGuideRoom>> roomsByIDsRepository(Ref ref, List<int> roomsIDs) async {
  Future<DigitalGuideRoom> getRoom(int roomID) {
    return ref
        .getAndCacheDataFromDigitalGuide("rooms/$roomID", DigitalGuideRoom.fromJson, onRetry: ref.invalidateSelf)
        .castAsObject;
  }

  final rooms = await Future.wait(roomsIDs.map(getRoom));

  return rooms.lock;
}

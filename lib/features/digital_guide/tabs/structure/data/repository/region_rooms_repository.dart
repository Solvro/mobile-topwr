import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../rooms/data/models/digital_guide_room.dart";

part "region_rooms_repository.g.dart";

@riverpod
Future<IList<DigitalGuideRoom>> regionRoomsRepository(
  Ref ref,
  List<int> roomsIDs,
) async {
  Future<DigitalGuideRoom> getRoom(int roomID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "rooms/$roomID",
      DigitalGuideRoom.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final rooms = await Future.wait(roomsIDs.map(getRoom));

  return rooms.lock;
}

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/dressing_room.dart";

part "dressing_rooms_repository.g.dart";

@riverpod
Future<IList<DressingRoom>> dressingRoomsRepository(
  Ref ref,
  List<int> dressingRoomsIDs,
) async {
  Future<DressingRoom> getDressingRoom(int dressingRoomID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "dressing_rooms/$dressingRoomID",
      DressingRoom.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final dressingRooms =
      await Future.wait(dressingRoomsIDs.map(getDressingRoom));

  return dressingRooms.lock;
}

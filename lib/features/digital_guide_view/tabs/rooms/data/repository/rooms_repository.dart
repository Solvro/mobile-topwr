import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/level.dart";
import "../../../../data/models/level_with_regions.dart";
import "../../../../data/models/region.dart";
import "../models/digital_guide_room.dart";

part "rooms_repository.g.dart";

@riverpod
Future<IList<DigitalGuideRoom>> roomsRepository(
  Ref ref,
  LevelWithRegions level,
) async {
  Future<DigitalGuideRoom> getDigitalGuideRoom(int roomId) async {
    final String endpoint = "rooms/$roomId";
    return ref.getAndCacheDataFromDigitalGuide(
      endpoint,
      DigitalGuideRoom.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final roomsIds = level.regions.expand((region) => region.roomsIds);
  final rooms = await Future.wait(roomsIds.map(getDigitalGuideRoom));
  return rooms.toIList();
}

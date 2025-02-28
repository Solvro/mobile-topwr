import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/room_platforms_response.dart";

part "room_platforms_repository.g.dart";

@riverpod
Future<RoomPlatformsResponse> roomPlatformsRepository(Ref ref, int roomStairsId) async {
  return ref.getAndCacheDataFromDigitalGuide(
    "platforms/$roomStairsId",
    RoomPlatformsResponse.fromJson,
    onRetry: () => ref.invalidateSelf(),
  );
}

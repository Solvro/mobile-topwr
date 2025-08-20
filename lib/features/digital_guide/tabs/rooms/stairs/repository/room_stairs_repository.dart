import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/room_stairs_response.dart";

part "room_stairs_repository.g.dart";

@riverpod
Future<RoomStairsResponse> roomStairsRepository(Ref ref, int roomStairsId) {
  return ref
      .getAndCacheDataFromDigitalGuide(
        "room_stairs/$roomStairsId",
        RoomStairsResponse.fromJson,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;
}

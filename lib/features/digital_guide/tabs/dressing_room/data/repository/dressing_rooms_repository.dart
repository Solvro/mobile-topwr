import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/digital_guide_response.dart";
import "../models/digital_guide_dressing_room.dart";

part "dressing_rooms_repository.g.dart";

@riverpod
Future<IList<DigitalGuideDressingRoom>> dressingRoomsRepository(Ref ref, DigitalGuideResponse building) {
  final endpoint = "dressing_rooms/?building=${building.id}";
  return ref
      .getAndCacheDataFromDigitalGuide(endpoint, DigitalGuideDressingRoom.fromJson, onRetry: ref.invalidateSelf)
      .castAsList;
}

@riverpod
Future<IList<DigitalGuideDressingRoom>> dressingRoomsFromIDsRepository(Ref ref, List<int> dressingRoomsIDs) async {
  Future<DigitalGuideDressingRoom> getDressingRoomById(int dressingRoomID) {
    return ref
        .getAndCacheDataFromDigitalGuide(
          "dressing_rooms/$dressingRoomID",
          DigitalGuideDressingRoom.fromJson,
          onRetry: ref.invalidateSelf,
        )
        .castAsObject;
  }

  final dressingRooms = await Future.wait(dressingRoomsIDs.map(getDressingRoomById));

  return dressingRooms.lock;
}

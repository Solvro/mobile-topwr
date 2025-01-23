import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/digital_guide_response.dart";
import "../models/digital_guide_dressing_room.dart";

part "dressing_rooms_repository.g.dart";

@riverpod
Future<IList<DigitalGuideDressingRoom>> dressingRoomsRepository(
  Ref ref,
  DigitalGuideResponse building,
) async {
  final endpoint = "dressing_rooms/?building=${building.id}";
  return ref.getAndCacheDataFromDigitalGuide(
    endpoint,
    (List<dynamic> json) => json
        .whereType<Map<String, dynamic>>()
        .map(DigitalGuideDressingRoom.fromJson)
        .toIList(),
    onRetry: () => ref.invalidateSelf(),
  );
}

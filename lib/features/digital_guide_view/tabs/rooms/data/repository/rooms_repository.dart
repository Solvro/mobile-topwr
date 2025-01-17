import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/digital_guide_response.dart";
import "../models/digital_guide_room.dart";

part "rooms_repository.g.dart";

@riverpod
Future<IList<DigitalGuideRoom>> roomsRepository(
  Ref ref,
  DigitalGuideResponse building,
) async {
  final String endpoint = "rooms/?building=${building.id}";

  return ref.getAndCacheDataFromDigitalGuide(
    endpoint,
    (List<dynamic> json) => json
        .whereType<Map<String, dynamic>>()
        .map(DigitalGuideRoom.fromJson)
        .toIList(),
    onRetry: () => ref.invalidateSelf(),
  );
}

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../buildings_view/repository/buildings_repository.dart";
import "../../../digital_guide/data/api/digital_guide_get_and_cache.dart";
import "../models/digital_guide_object_model.dart";

part "digital_guide_object_repository.g.dart";

@riverpod
Future<({DigitalGuideObjectModel digitalGuideData, String? photoUrl})> digitalGuideObjectRepository(
  Ref ref,
  String ourId,
) async {
  final buildings = await ref.watch(buildingsRepositoryProvider.future);
  final building = buildings.firstWhere(
    (building) => building.id == ourId,
    orElse: () => throw Exception("No such building: $ourId"),
  );
  final digitalGuideId = building.externalDigitalGuideIdOrURL;
  final digitalGuideData =
      await ref
          .getAndCacheDataFromDigitalGuide(
            "objects/$digitalGuideId",
            DigitalGuideObjectModel.fromJson,
            onRetry: ref.invalidateSelf,
          )
          .castAsObject;
  return (digitalGuideData: digitalGuideData, photoUrl: building.cover?.filename_disk);
}

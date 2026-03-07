import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../digital_guide/data/api/digital_guide_get_and_cache.dart";
import "../../../multilayer_map/data/repositories/buildings_repository.dart";
import "../../../multilayer_map/data/repositories/polinkas_repository.dart";
import "../models/digital_guide_object_model.dart";

part "digital_guide_object_repository.g.dart";

enum DigitalGuideOtherObjectType { building, polinka }

@riverpod
Future<({DigitalGuideObjectModel digitalGuideData, String? photoUrl})> digitalGuideObjectRepository(
  Ref ref,
  String ourId,
  DigitalGuideOtherObjectType type,
) async {
  final (digitalGuideId, photoUrl) = await switch (type) {
    DigitalGuideOtherObjectType.building => () async {
      final building = (await ref.watch(
        buildingsRepositoryProvider.future,
      )).firstWhere((b) => b.id == ourId, orElse: () => throw Exception("No such building: $ourId"));
      return (building.externalDigitalGuideIdOrUrl, building.cover?.effectiveUrl);
    }(),
    DigitalGuideOtherObjectType.polinka => () async {
      final polinka = (await ref.watch(
        polinkasRepositoryProvider.future,
      )).firstWhere((p) => p.id.toString() == ourId, orElse: () => throw Exception("No such polinka: $ourId"));
      return (polinka.externalDigitalGuideIdOrUrl, polinka.photo?.effectiveUrl);
    }(),
  };
  final digitalGuideData = await ref
      .getAndCacheDataFromDigitalGuide(
        "objects/$digitalGuideId",
        DigitalGuideObjectModel.fromJson,
        onRetry: () => ref.invalidateSelf(),
      )
      .castAsObject;
  return (digitalGuideData: digitalGuideData, photoUrl: photoUrl);
}

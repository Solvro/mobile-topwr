import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../buildings_view/repository/buildings_repository.dart";
import "../../tabs/information_points/models/digital_guide_information_points.dart";
import "../../tabs/information_points/repository/information_point_repository.dart";
import "../api/digital_guide_get_and_cache.dart";
import "../models/digital_guide_response.dart";

part "digital_guide_repository.g.dart";

@riverpod
Future<
    ({
      DigitalGuideResponse digitalGuideData,
      String? photoUrl,
      /*IList<DigitalGuideInformationPoint>? informationPoint*/
    })> digitalGuideRepository(
  Ref ref,
  String ourId,
) async {
  final buildings = await ref.watch(buildingsRepositoryProvider.future);
  final building = buildings.firstWhere(
    (building) => building.id == ourId,
    orElse: () => throw Exception("No such building: $ourId"),
  );
  final digitalGuideId = building.externalDigitalGuideIdOrURL;
  final digitalGuideData = await ref.getAndCacheDataFromDigitalGuide(
    "buildings/$digitalGuideId",
    DigitalGuideResponse.fromJson,
    onRetry: () => ref.invalidateSelf(),
  );
  final informationPoint = await ref
      .watch(informationPointRepositoryProvider(digitalGuideData.id).future);
  await ref.clearCache("buildings/$digitalGuideId", 7);

  print(informationPoint);
  return (
    digitalGuideData: digitalGuideData,
    photoUrl: building.cover?.filename_disk,
    //   informationPoint: informationPoint,
  );
}

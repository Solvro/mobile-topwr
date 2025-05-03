import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/json.dart";
import "../../../data/api/digital_guide_get_and_cache.dart";
import "../models/digital_guide_information_points.dart";

part "information_point_repository.g.dart";

@riverpod
Future<DigitalGuideInformationPoint?> informationPointRepository(Ref ref, int buildingId) async {
  final data =
      await ref
          .getAndCacheDataFromDigitalGuide(
            "information_points/?building=$buildingId",
            DigitalGuideInformationPoint.fromJson,
            onRetry: ref.invalidateSelf,
          )
          .castAsList;

  if (data.isEmpty) return null;

  return data.first;
}

@riverpod
Future<IList<DigitalGuideInformationPoint>> informationPointsFromIDRepository(
  Ref ref,
  List<int> informationPointsIDs,
) async {
  Future<DigitalGuideInformationPoint> getInformationPoint(int informationPointID) async {
    return ref
        .getAndCacheDataFromDigitalGuide(
          "information_points/$informationPointID",
          DigitalGuideInformationPoint.fromJson,
          onRetry: ref.invalidateSelf,
        )
        .castAsObject;
  }

  final informationPoints = await Future.wait(informationPointsIDs.map(getInformationPoint));

  return informationPoints.lock;
}

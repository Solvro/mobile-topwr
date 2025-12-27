import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../../../../api_base_rest/client/json.dart";
import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/information_point.dart";

part "information_points_repository.g.dart";

@riverpod
Future<IList<InformationPoint>> informationPointsRepository(Ref ref, List<int> informationPointsIDs) async {
  Future<InformationPoint> getInformationPoint(int informationPointID) {
    return ref
        .getAndCacheDataFromDigitalGuide(
          "information_points/$informationPointID",
          InformationPoint.fromJson,
          onRetry: ref.invalidateSelf,
        )
        .castAsObject;
  }

  final informationPoints = await Future.wait(informationPointsIDs.map(getInformationPoint));

  return informationPoints.lock;
}

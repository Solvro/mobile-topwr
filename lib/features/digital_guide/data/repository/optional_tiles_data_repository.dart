import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../tabs/information_points/repository/information_point_repository.dart";
import "../models/optional_tiles_data.dart";

part "optional_tiles_data_repository.g.dart";

@riverpod
Future<OptionalTilesData> optionalTilesDataRepository(Ref ref, int buildingId) async {
  final infoPoint = await ref.watch(informationPointRepositoryProvider(buildingId).future);
  return OptionalTilesData(informationPoint: infoPoint);
}

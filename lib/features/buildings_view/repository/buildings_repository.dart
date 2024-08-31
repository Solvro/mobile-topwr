import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../config/ttl_config.dart";
import "../model/building_model.dart";
import "getBuildings.graphql.dart";

part "buildings_repository.g.dart";

typedef Building = Query$GetBuildings$Buildings;

@riverpod
Future<IList<BuildingModel?>?> buildingsRepository(
  BuildingsRepositoryRef ref,
) async {
  final results = await ref.queryGraphql(
    Options$Query$GetBuildings(),
    TtlKey.buildingsRepository,
  );
  return results?.Buildings.map(BuildingModel.from).toIList();
}

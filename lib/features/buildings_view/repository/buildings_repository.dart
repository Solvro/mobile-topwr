import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base/watch_query_adapter.dart";
import "../../../../config/ttl_config.dart";
import "../model/building_model.dart";
import "getBuildings.graphql.dart";

part "buildings_repository.g.dart";

typedef Building = Query$GetBuildings$Buildings;

@riverpod
Stream<List<BuildingModel?>?> buildingsRepository(
  BuildingsRepositoryRef ref,
) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetBuildings(eagerlyFetchResults: true),
    TtlKey.buildingsRepository,
  );

  yield* stream.map(
    (event) => event?.Buildings.map(BuildingModel.from).toList(),
  );
}

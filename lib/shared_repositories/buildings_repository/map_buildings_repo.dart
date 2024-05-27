import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../api_base/watch_query_adapter.dart';
import '../../api_base/ttl/ttl_config.dart';
import 'building_model.dart';
import 'getMapBuildings.graphql.dart';

part 'map_buildings_repo.g.dart';

typedef Building = Query$GetMapBuildings$Buildings;

@riverpod
Stream<List<BuildingModel?>?> mapBuildingsRepository(
    MapBuildingsRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetMapBuildings(eagerlyFetchResults: true),
    TtlKey.mapBuildingsRepository,
  );

  yield* stream.map(
    (event) => event?.Buildings.map(BuildingModel.from).toList(),
  );
}

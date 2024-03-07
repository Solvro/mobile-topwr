import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../api_base/watch_query_adapter.dart';
import 'getMapBuildings.graphql.dart';

part 'map_buildings_repo.g.dart';

typedef Building = Query$GetMapBuildings$maps;

@riverpod
Stream<List<Building?>?> mapBuildingsRepository(
    MapBuildingsRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetMapBuildings(eagerlyFetchResults: true),
    "MapBuildingsRepositoryRef",
  );

  yield* stream.map(
    (event) => event?.maps,
  );
}

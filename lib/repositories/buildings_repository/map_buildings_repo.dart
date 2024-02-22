import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../api_base/gql_client_provider.dart';
import '../../../api_base/watch_query_adapter.dart';

import 'getMapBuildings.graphql.dart';
part 'map_buildings_repo.g.dart';

typedef Building = Query$GetMapBuildings$maps;

@riverpod
Stream<List<Building?>?> mapBuildingsRepository(
    MapBuildingsRepositoryRef ref) async* {
  final client = await ref.watch(gqlClientProvider);
  final stream = ref.watchQueryWithCache(
      client, WatchOptions$Query$GetMapBuildings(eagerlyFetchResults: true));

  yield* stream.map(
    (event) => event?.maps,
  );
}

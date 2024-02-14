import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../api_base/gql_client_provider.dart';
import '../../../../api_base/watch_query_adapter.dart';
import 'getMapsList.graphql.dart';
part 'maps_list_repository.g.dart';

typedef Maps = Query$GetMapsList$maps;

@riverpod
Stream<List<Maps?>?> mapsListRepository(MapsListRepositoryRef ref) async*{
  final client = await ref.watch(gqlClientProvider);
  final stream = ref.watchQueryWithCache(client,
    WatchOptions$Query$GetMapsList(
        eagerlyFetchResults: true
    ),
  );
  yield* stream.map(
          (event)=>event?.maps
  );
}
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/gql_client_provider.dart';
import '../../../../api_base/watch_query_adapter.dart';
import 'getScientificCircles.graphql.dart';

part 'scientific_circles_repository.g.dart';

typedef ScientificCircle = Query$GetScientificCircles$scientificCircles; // just alias for shorter type name

@riverpod
Stream<List<ScientificCircle?>?> scientificCirclesRepository(ScientificCirclesRepositoryRef ref) async* {
  final client = await ref.watch(gqlClientProvider);
  final stream = ref.watchQueryWithCache(
    client,
    WatchOptions$Query$GetScientificCircles(
      eagerlyFetchResults: true,
    ),
  );
  yield* stream.map(
        (event) => event?.scientificCircles,
  );
}
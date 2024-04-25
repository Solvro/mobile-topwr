import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/watch_query_adapter.dart';
import '../../../api_base/ttl/ttl_config.dart';
import 'getScientificCircles.graphql.dart';

part 'scientific_circles_repository.g.dart';

typedef ScientificCircle
    = Query$GetScientificCircles$scientificCircles; // just alias for shorter type name

@riverpod
Stream<List<ScientificCircle?>?> scientificCirclesRepository(
    ScientificCirclesRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetScientificCircles(eagerlyFetchResults: true),
    TtlKey.sciCirclesRepository,
  );
  yield* stream.map(
    (event) => event?.scientificCircles,
  );
}

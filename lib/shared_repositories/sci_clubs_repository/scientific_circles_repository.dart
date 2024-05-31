import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../api_base/watch_query_adapter.dart';
import '../../api_base/ttl/ttl_config.dart';
import 'getScientificCircles.graphql.dart';

part 'scientific_circles_repository.g.dart';

typedef ScientificCircle
    = Query$GetScientificCircles$Scientific_Circles; // just alias for shorter type name

@riverpod
Stream<List<ScientificCircle?>?> scientificCirclesRepository(
    ScientificCirclesRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetScientificCircles(eagerlyFetchResults: true),
    TtlKey.sciCirclesRepository,
  );
  yield* stream.map(
    (event) => event?.Scientific_Circles.sortBySourceTypes().toList(),
  );
}

extension SortBySourceType on Iterable<ScientificCircle> {
  Iterable<ScientificCircle> _filter(String source) {
    return where((element) => element.source == source);
  }

  Iterable<ScientificCircle> sortBySourceTypes() {
    final p0 = _filter("manual_entry");
    final p1 = _filter("aktywni_website");
    final p2 = _filter("student_department");
    return p0.followedBy(p1).followedBy(p2).toList();
  }
}

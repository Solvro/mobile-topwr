import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base/watch_query_adapter.dart";
import "../../../../config/ttl_config.dart";
import "getScienceClubs.graphql.dart";

part "science_clubs_repository.g.dart";

typedef ScienceClub = Query$GetScienceClubs$Scientific_Circles;
// just alias for shorter type name

@riverpod
Stream<List<ScienceClub?>?> scienceClubsRepository(
  ScienceClubsRepositoryRef ref,
) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetScienceClubs(eagerlyFetchResults: true),
    TtlKey.scienceClubsRepository,
  );
  yield* stream.map(
    (event) => event?.Scientific_Circles.sortBySourceTypes().toList(),
  );
}

extension SortBySourceTypeX on Iterable<ScienceClub> {
  Iterable<ScienceClub> _filter(String source) {
    return where((element) => element.source == source);
  }

  Iterable<ScienceClub> sortBySourceTypes() {
    final p0 = _filter("manual_entry");
    final p1 = _filter("aktywni_website");
    final p2 = _filter("student_department");
    return p0.followedBy(p1).followedBy(p2).toList();
  }
}

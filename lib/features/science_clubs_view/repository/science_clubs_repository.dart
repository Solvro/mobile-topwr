import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base/watch_query_adapter.dart";
import "../../../../config/ttl_config.dart";
import "getScienceClubs.graphql.dart";

part "science_clubs_repository.g.dart";

typedef ScienceClub = Query$GetScienceClubs$Scientific_Circles;

@riverpod
Stream<IList<ScienceClub>> scienceClubsRepository(
  ScienceClubsRepositoryRef ref,
) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetScienceClubs(eagerlyFetchResults: true),
    TtlKey.scienceClubsRepository,
  );
  yield* stream.map(
    (event) => (event?.Scientific_Circles.sortBySourceTypes() ?? []).toIList(),
  );
}

extension IsSolvroX on ScienceClub {
  bool get isSolvro => name.contains("Solvro");
}

extension SortBySourceTypeX on Iterable<ScienceClub> {
  Iterable<ScienceClub> _filterByType(
    String source, {
    bool includeSolvro = false,
  }) {
    return where(
      (element) =>
          element.source == source && (includeSolvro || !element.isSolvro),
    );
  }

  List<ScienceClub> sortBySourceTypes() {
    final solvro = firstWhereOrNull((element) => element.isSolvro);
    final manualSource = _filterByType("manual_entry").toList()..shuffle();
    final activeWebSource = _filterByType("aktywni_website").toList()
      ..shuffle();
    final studentDepartmentSource = _filterByType("student_department").toList()
      ..shuffle();

    return [
      if (solvro != null) solvro,
      ...manualSource,
      ...activeWebSource,
      ...studentDepartmentSource,
    ];
  }
}

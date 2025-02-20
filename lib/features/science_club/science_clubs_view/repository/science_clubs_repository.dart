import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../config/ttl_config.dart";
import "../../../../api_base/query_adapter.dart";
import "../../../../utils/ilist_nonempty.dart";
import "getScienceClubs.graphql.dart";

part "science_clubs_repository.g.dart";

typedef ScienceClub = Query$GetScienceClubs$Scientific_Circles;

@riverpod
Future<IList<ScienceClub>> scienceClubsRepository(Ref ref) async {
  final results = await ref.queryGraphql(
    Options$Query$GetScienceClubs(),
    TtlKey.scienceClubsRepository,
  );
  return (results?.Scientific_Circles.sortBySourceTypes()).toIList();
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

  Iterable<ScienceClub> withLogo() {
    return where(
      (element) => element.logo != null,
    );
  }

  Iterable<ScienceClub> withoutLogo() {
    return where(
      (element) => element.logo == null,
    );
  }

  List<ScienceClub> sortBySourceTypes() {
    final solvro = firstWhereOrNull((element) => element.isSolvro);
    final manualSourceWithPhotos =
        _filterByType("manual_entry").withLogo().toList()..shuffle();
    final manualSourceWithoutPhotos =
        _filterByType("manual_entry").withoutLogo().toList()..shuffle();
    final activeWebSourceWithPhotos =
        _filterByType("aktywni_website").withLogo().toList()..shuffle();
    final activeWebSourceWithoutPhotos =
        _filterByType("aktywni_website").withoutLogo().toList()..shuffle();
    final studentDepartmentSourceWithPhotos =
        _filterByType("student_department").withLogo().toList()..shuffle();
    final studentDepartmentSourceWithoutPhotos =
        _filterByType("student_department").withoutLogo().toList()..shuffle();

    return [
      if (solvro != null) solvro,
      ...manualSourceWithPhotos,
      ...manualSourceWithoutPhotos,
      ...activeWebSourceWithPhotos,
      ...activeWebSourceWithoutPhotos,
      ...studentDepartmentSourceWithPhotos,
      ...studentDepartmentSourceWithoutPhotos,
    ];
  }
}

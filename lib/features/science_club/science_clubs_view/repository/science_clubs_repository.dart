import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";
import "../model/science_clubs.dart";
import "../science_clubs_view.dart";

part "science_clubs_repository.g.dart";

@riverpod
Future<IList<ScienceClub>> scienceClubsRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  const scienceClubsEndpoint = "/student_organizations?cover=true&links=true&logo=true&tags=true";
  const departmentsEndpoint = "/departments";

  final responses = await Future.wait([
    ref.getAndCacheData(
      apiUrl + scienceClubsEndpoint,
      TtlStrategy.get(TtlKey.scienceClubsRepository).inDays,
      ScienceClubsResponse.fromJson,
      extraValidityCheck: (_) => true,
      localizedOfflineMessage: ScienceClubsView.localizedOfflineMessage,
      onRetry: ref.invalidateSelf,
    ),
    ref.getAndCacheData(
      apiUrl + departmentsEndpoint,
      TtlStrategy.get(TtlKey.departmentsRepository).inDays,
      DepartmentsResponse.fromJson,
      extraValidityCheck: (_) => true,
      localizedOfflineMessage: ScienceClubsView.localizedOfflineMessage,
      onRetry: ref.invalidateSelf,
    ),
  ]);

  final scienceClubsResponse = responses[0] as ScienceClubsResponse;
  final departmentsResponse = responses[1] as DepartmentsResponse;
  final departmentsMap = {for (final department in departmentsResponse.data) department.id: department};

  final clubs =
      scienceClubsResponse.data
          .map(
            (club) => club.copyWith(
              departmentName: departmentsMap[club.departmentId]?.name,
              code: departmentsMap[club.departmentId]?.code,
              betterCode: departmentsMap[club.departmentId]?.betterCode,
            ),
          )
          .where((club) => club.organizationStatus.toScienceClubStatus != ScienceClubStatus.archived)
          .sortBySourceTypes()
          .toIList();
  return clubs;
}

extension IsSolvroX on ScienceClub {
  bool get isSolvro => name.contains("Solvro");
}

extension SortBySourceTypeX on Iterable<ScienceClub> {
  Iterable<ScienceClub> _filterByType(String source, {bool includeSolvro = false}) {
    return where((element) => element.source == source && (includeSolvro || !element.isSolvro));
  }

  Iterable<ScienceClub> withLogo() {
    return where((element) => element.logo != null);
  }

  Iterable<ScienceClub> withoutLogo() {
    return where((element) => element.logo == null);
  }

  List<ScienceClub> sortBySourceTypes() {
    final solvro = firstWhereOrNull((element) => element.isSolvro);
    final manualSourceWithPhotos = _filterByType("manual_entry").withLogo().toList()..shuffle();
    final manualSourceWithoutPhotos = _filterByType("manual_entry").withoutLogo().toList()..shuffle();
    final activeWebSourceWithPhotos = _filterByType("aktywni_website").withLogo().toList()..shuffle();
    final activeWebSourceWithoutPhotos = _filterByType("aktywni_website").withoutLogo().toList()..shuffle();
    final studentDepartmentSourceWithPhotos = _filterByType("student_department").withLogo().toList()..shuffle();
    final studentDepartmentSourceWithoutPhotos = _filterByType("student_department").withoutLogo().toList()..shuffle();

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

enum ScienceClubStatus { active, archived }

extension ScienceClubStatusX on String? {
  ScienceClubStatus get toScienceClubStatus =>
      this == "archived" ? ScienceClubStatus.archived : ScienceClubStatus.active;
}

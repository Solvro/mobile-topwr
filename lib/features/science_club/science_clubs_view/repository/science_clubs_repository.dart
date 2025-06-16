import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";
import "../model/science_clubs.dart";
import "../science_clubs_view.dart";

part "science_clubs_repository.g.dart";

@riverpod
Future<IList<ScienceClub>> scienceClubsRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  const scienceClubsEndpoint = "/student_organizations?cover=true&links=true&logo=true&tags=true&department=true";

  final response =
      await ref
          .getAndCacheDataWithTranslation(
            apiUrl + scienceClubsEndpoint,
            TtlStrategy.get(TtlKey.scienceClubsRepository).inDays,
            ScienceClubsResponse.fromJson,
            extraValidityCheck: (_) => true,
            localizedOfflineMessage: ScienceClubsView.localizedOfflineMessage,
            onRetry: ref.invalidateSelf,
          )
          .castAsObject;

  return response.data
      .whereType<ScienceClub>()
      .map((club) => club)
      .where((club) => club.organizationStatus != ScienceClubStatus.archived)
      .sortBySourceTypes()
      .toIList();
}

extension IsSolvroX on ScienceClub {
  bool get isSolvro => name.contains("Solvro");
}

extension SortBySourceTypeX on Iterable<ScienceClub> {
  Iterable<ScienceClub> _filterByType(ScienceClubSource source, {bool includeSolvro = false}) {
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
    final manualSourceWithPhotos = _filterByType(ScienceClubSource.manualEntry).withLogo().toList()..shuffle();
    final manualSourceWithoutPhotos = _filterByType(ScienceClubSource.manualEntry).withoutLogo().toList()..shuffle();
    final activeWebSourceWithPhotos = _filterByType(ScienceClubSource.pwrActiveWebsite).withLogo().toList()..shuffle();
    final activeWebSourceWithoutPhotos =
        _filterByType(ScienceClubSource.pwrActiveWebsite).withoutLogo().toList()..shuffle();
    final studentDepartmentSourceWithPhotos =
        _filterByType(ScienceClubSource.studentDepartment).withLogo().toList()..shuffle();
    final studentDepartmentSourceWithoutPhotos =
        _filterByType(ScienceClubSource.studentDepartment).withoutLogo().toList()..shuffle();

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

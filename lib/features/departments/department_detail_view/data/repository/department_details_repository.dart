import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/json.dart";
import "../../../../../api_base_rest/translations/translate.dart";
import "../../../../../config/env.dart";
import "../../../../science_club/science_clubs_view/model/science_clubs.dart";
import "../../../../science_club/science_clubs_view/repository/science_clubs_repository.dart";
import "../models/department_details.dart";

part "department_details_repository.g.dart";

typedef DepartmentWithSciClubs = ({DepartmentDetails department, IList<ScienceClub> sciclubs});
@riverpod
Future<DepartmentWithSciClubs> departmentDetailsRepository(Ref ref, int id) async {
  final endpoint = "/departments/$id?fieldsOfStudy=true&departmentLinks=true&logo=true";
  final url = "${Env.mainRestApiUrl}$endpoint";

  final response = await ref
      .getAndCacheDataWithTranslation(
        url,
        DepartmentDetailsResponse.fromJson,
        extraValidityCheck: (_) => true,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;
  final scienceClubs = await ref.watch(scienceClubsRepositoryProvider.future);
  final filtered = scienceClubs.where((sciClub) => sciClub.department?.id == response.data.id).toIList();

  return (department: response.data, sciclubs: filtered);
}

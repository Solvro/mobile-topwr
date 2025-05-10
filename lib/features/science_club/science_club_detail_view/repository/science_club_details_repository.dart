import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";
import "../model/science_club_details.dart";
import "../science_club_detail_view.dart";

part "science_club_details_repository.g.dart";

@riverpod
Future<ScienceClubDetails?> scienceClubDetailsRepository(Ref ref, String id) async {
  final apiUrl = Env.mainRestApiUrl;
  final clubDetailsEndpoint = "/student_organizations/$id?cover=true&links=true&logo=true&tags=true";
  const departmentsEndpoint = "/departments";

  final responses = await Future.wait([
    ref.getAndCacheData(
      apiUrl + clubDetailsEndpoint,
      TtlStrategy.get(TtlKey.scienceClubDetailsRepository).inDays,
      ClubDetailsResponse.fromJson,
      extraValidityCheck: (_) => true,
      localizedOfflineMessage: ScienceClubDetailView.localizedOfflineMessage,
      onRetry: ref.invalidateSelf,
    ),
    ref.getAndCacheData(
      apiUrl + departmentsEndpoint,
      TtlStrategy.get(TtlKey.departmentsRepository).inDays,
      DepartmentsResponse.fromJson,
      extraValidityCheck: (_) => true,
      localizedOfflineMessage: ScienceClubDetailView.localizedOfflineMessage,
      onRetry: ref.invalidateSelf,
    ),
  ]);

  final clubDetailsResponse = responses[0] as ClubDetailsResponse;
  final departmentsResponse = responses[1] as DepartmentsResponse;

  final departmentsMap = {for (final department in departmentsResponse.data) department.id: department};

  final clubDetails = clubDetailsResponse.data;
  final departmentName = departmentsMap[clubDetails.departmentId]?.name;

  return clubDetails.copyWith(departmentName: departmentName);
}

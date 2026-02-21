import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../model/science_club_details.dart";
import "../science_club_detail_view.dart";

part "science_club_details_repository.g.dart";

@riverpod
Future<ScienceClubDetails?> scienceClubDetailsRepository(Ref ref, int id) async {
  final apiUrl = Env.mainRestApiUrl;
  final clubDetailsEndpoint = "/student_organizations/$id?cover=true&links=true&logo=true&tags=true&department=true";

  final response = await ref.getAndCacheDataWithTranslation(
    apiUrl + clubDetailsEndpoint,
    ClubDetailsResponse.fromJson,
    extraValidityCheck: (_) => true,
    localizedOfflineMessage: ScienceClubDetailView.localizedOfflineMessage,
    onRetry: ref.invalidateSelf,
  );

  return response.castAsObject.data;
}

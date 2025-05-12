import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";
import "../model/science_club_details.dart";
import "../science_club_detail_view.dart";

part "science_club_details_repository.g.dart";

@riverpod
Future<ScienceClubDetails?> scienceClubDetailsRepository(Ref ref, int id) async {
  final apiUrl = Env.mainRestApiUrl;
  final clubDetailsEndpoint = "/student_organizations/$id?cover=true&links=true&logo=true&tags=true&department=true";

  final response = await ref.getAndCacheData(
    apiUrl + clubDetailsEndpoint,
    TtlStrategy.get(TtlKey.scienceClubDetailsRepository).inDays,
    ClubDetailsResponse.fromJson,
    extraValidityCheck: (_) => true,
    localizedOfflineMessage: ScienceClubDetailView.localizedOfflineMessage,
    onRetry: ref.invalidateSelf,
  );

  return response.data;
}

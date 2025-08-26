import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base_rest/client/json.dart";
import "../../../api_base_rest/translations/translate.dart";
import "../../../config/env.dart";
import "../../academic_calendar/widgets/home_screen_greeting.dart";
import "../data/models/planner_banner_models.dart";

part "planner_advert_repository.g.dart";

@riverpod
Future<PlannerBanner?> plannerAdvertContentRepository(Ref ref) async {
  final url = "${Env.mainRestApiUrl}/banners";

  final response = await ref
      .getAndCacheDataWithTranslation(
        url,
        PlannerBannerResponse.fromJson,
        extraValidityCheck: (_) => true,
        localizedOfflineMessage: Greeting.localizedOfflineMessage,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;

  final active = response.data.where((b) => b.shouldRender && !b.draft).toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  final banner = active.isNotEmpty ? active.first : null;

  return banner;
}

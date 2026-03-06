import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base_rest/client/json.dart";
import "../../../api_base_rest/translations/translate.dart";
import "../../../config/env.dart";
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
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;

  final now = DateTime.now();
  final active =
      response.data
          .where(
            (b) =>
                !b.draft &&
                (b.visibleFrom == null || b.visibleFrom!.isBefore(now)) &&
                (b.visibleUntil == null || b.visibleUntil!.isAfter(now)),
          )
          .toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  final banner = active.isNotEmpty ? active.first : null;
  return banner;
}

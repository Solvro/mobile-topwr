import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base_rest/cache/cache.dart";
import "../../../config/env.dart";

import "../../../config/ttl_config.dart";
import "../guide_view.dart";
import "../models/guide_data.dart";
part "guide_repository.g.dart";

@riverpod
class GuideRepository extends _$GuideRepository {
  static final _apiUrl = Env.restApiUrl;
  @override
  Future<IList<GuideData>> build() async {
    final guideResponse = await ref.getAndCacheData(
      "$_apiUrl/guide_articles",
      TtlStrategy.get(TtlKey.guideRepository).inDays,
      GuideDataResponse.fromJson,
      extraValidityCheck: (_) => true,
      localizedOfflineMessage: GuideView.localizedOfflineMessage,
      onRetry: ref.invalidateSelf,
    );

    return guideResponse.data.map((data) => data).toIList();
  }
}

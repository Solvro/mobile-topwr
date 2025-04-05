import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";

import "../../../../config/ttl_config.dart";
import "../../guide_view.dart";
import "../models/guide_data.dart";
part "guide_repository.g.dart";

@riverpod
Future<IList<GuideData>> guideRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  final guideResponse =
      await ref
          .getAndCacheData(
            "$apiUrl/guide_articles?image=true",
            TtlStrategy.get(TtlKey.guideRepository).inDays,
            GuideDataResponse.fromJson,
            extraValidityCheck: (_) => true,
            localizedOfflineMessage: GuideView.localizedOfflineMessage,
            onRetry: ref.invalidateSelf,
          )
          .castAsObject;
  return guideResponse.data.map((data) => data).toIList();
}

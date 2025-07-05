import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";
import "../../../guide_view/guide_view.dart";
import "../models/guide_details.dart";

part "guide_details_repository.g.dart";

@riverpod
Future<GuideDetails> guideDetailsRepository(Ref ref, int id) async {
  final apiUrl = Env.mainRestApiUrl;
  final endpoint = "/guide_articles/$id?description=true&guideQuestions=true&image=true&guideAuthors=true";

  final response =
      await ref
          .getAndCacheDataWithTranslation(
            apiUrl + endpoint,
            TtlStrategy.get(TtlKey.guideDetailsRepository).inDays,
            GuideDetailsResponse.fromJson,
            extraValidityCheck: (_) => true,
            localizedOfflineMessage: GuideView.localizedOfflineMessage,
            onRetry: ref.invalidateSelf,
          )
          .castAsObject;
  return response.data;
}

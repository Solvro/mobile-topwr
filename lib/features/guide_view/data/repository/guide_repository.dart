import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";

import "../../guide_view.dart";
import "../models/guide_data.dart";
part "guide_repository.g.dart";

@riverpod
Future<IList<GuideData>> guideRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  final guideResponse = await ref
      .getAndCacheDataWithTranslation(
        "$apiUrl/guide_articles?image=true",
        GuideDataResponse.fromJson,
        extraValidityCheck: (_) => true,
        localizedOfflineMessage: GuideView.localizedOfflineMessage,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;
  return guideResponse.data.map((data) => data).toIList();
}

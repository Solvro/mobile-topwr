import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../../../../services/translations_service/data/preferred_lang_repository.dart";
import "../../presentation/news_list_view.dart";
import "../models/newsfeed_models.dart";

part "newsfeed_repository.g.dart";

@riverpod
Future<IList<Article>> newsfeedRepository(Ref ref) async {
  final currentLocale = await ref.watch(preferredLanguageRepositoryProvider.future);
  final endpoint = "/newsfeed/latest?completeOnly=false&lang=${currentLocale?.name ?? "pl"}";
  final url = "${Env.mainRestApiUrl}$endpoint";

  final response = await ref
      .getAndCacheData(
        url,
        NewsfeedResponse.fromJson,
        extraValidityCheck: (newsfeed) =>
            newsfeed.castAsObject.articles.isNotEmpty &&
            newsfeed.castAsObject.updateTime.isAfter(DateTime.now().subtract(const Duration(minutes: 30))),
        localizedOfflineMessage: NewsfeedView.localizedOfflineMessage,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;

  return response.articles;
}

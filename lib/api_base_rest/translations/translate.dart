import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../services/translations_service/business/solvro_translator.dart";
import "../../services/translations_service/data/preferred_lang_repository.dart";
import "../../utils/ilist_nonempty.dart";
import "../cache/cache.dart";
import "../client/dio_client.dart";
import "../client/json.dart";

extension TranslateX on Ref {
  Future<JSON<T>> getAndCacheDataWithTranslation<T extends TranslatableInterface>(
    String fullUrl,
    int ttlDays,
    T Function(Map<String, dynamic> json) fromJson, {
    // returns true if the data is still valid
    required bool Function(JSON<T> cachedData) extraValidityCheck,
    required String Function(BuildContext context) localizedOfflineMessage,
    VoidCallback? onRetry,
    AuthHeader? authHeader,
  }) async {
    final data = await getAndCacheData(
      fullUrl,
      ttlDays,
      fromJson,
      extraValidityCheck: extraValidityCheck,
      localizedOfflineMessage: localizedOfflineMessage,
      onRetry: onRetry,
      authHeader: authHeader,
    );

    final translator = watch(solvroTranslatorProvider);
    final locale = await watch(preferredLanguageRepositoryProvider.future) ?? SolvroLocale.pl;

    return switch (data) {
      ObjectJSON<T>(:final value) => ObjectJSON(await value.translate(translator, locale)),
      ListJSON<T>(:final value) => ListJSON(
        (await Future.wait(value.map((e) => e.translate(translator, locale)))).toIList(),
      ),
    };
  }
}

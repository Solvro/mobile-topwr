import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:translatable_generator/index.dart";

import "../../services/translations_service/data/repositories/translations_repository.dart";
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

    return switch (data) {
      ObjectJSON<T>(:final value) => ObjectJSON(await watch(translatableProvider(value).future)),
      ListJSON<T>(:final value) => ListJSON(
        (await Future.wait(value.map((e) => watch(translatableProvider(e).future)))).toIList(),
      ),
    };
  }
}

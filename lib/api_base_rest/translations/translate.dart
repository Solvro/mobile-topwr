import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../services/translations_service/business/translate_json.dart";
import "../../services/translations_service/data/models/translatable.dart";
import "../cache/cache.dart";
import "../client/dio_client.dart";
import "../client/json.dart";

extension TranslateX on Ref {
  Future<JSON<T>> getAndCacheDataWithTranslation<T extends Translatable>(
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
      ObjectJSON<T>(:final value) => translateJsonObject(value, fromJson),
      ListJSON<T>(:final value) => translateJsonList(value, fromJson),
    };
  }
}

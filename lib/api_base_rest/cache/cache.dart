import "dart:convert";
import "dart:typed_data";

import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../client/dio_client.dart";
import "../client/offline_error.dart";
import "cache_manager.dart";

extension DataCachingX on Ref {
  Future<void> clearCache(
    String fullUrl,
    int ttlDays,
  ) async {
    final cacheManager = watch(restCacheManagerProvider(ttlDays));
    await cacheManager.removeFile(fullUrl);
  }

  Future<T> getAndCacheData<T, JSON>(
    String fullUrl,
    int ttlDays,
    T Function(JSON json) fromJson, {
    // returns true if the data is still valid
    required bool Function(T cachedData) extraValidityCheck,
    required String Function(BuildContext context) localizedOfflineMessage,
    VoidCallback? onRetry,
    AuthHeader? authHeader,
  }) async {
    final cacheManager = watch(restCacheManagerProvider(ttlDays));

    final cachedFile = await cacheManager.getFileFromCache(fullUrl);
    if (cachedFile != null) {
      final cachedData = await cachedFile.file.readAsString();
      final data = fromJson(
        jsonDecode(cachedData) as JSON,
      );
      if (extraValidityCheck(data)) {
        return data;
      }
    }
    final response = await safeGetWatch(
      fullUrl,
      localizedMessage: localizedOfflineMessage,
      onRetry: onRetry,
      authHeader: authHeader,
    );
    final data = fromJson(response.data as JSON);
    if (extraValidityCheck(data)) {
      await cacheManager.putFile(
        fullUrl,
        Uint8List.fromList(utf8.encode(jsonEncode(response.data))),
        fileExtension: CacheManagerConfig.jsonExtesion,
      );
    }
    return data;
  }
}

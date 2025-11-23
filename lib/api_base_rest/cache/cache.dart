import "dart:convert";
import "dart:typed_data";

import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/ttl_config.dart";
import "../client/dio_client.dart";
import "../client/json.dart";
import "../client/offline_error.dart";
import "cache_manager.dart";

extension ClearAllCacheX on WidgetRef {
  Future<void> clearAllCache(TtlDays ttlDays) async {
    final cacheManager = watch(restCacheManagerProvider(ttlDays));
    await cacheManager.emptyCache();
  }
}

extension DataCachingX on Ref {
  Future<void> clearCache(String fullUrl, TtlDays ttlDays) async {
    final cacheManager = watch(restCacheManagerProvider(ttlDays));
    await cacheManager.removeFile(fullUrl);
  }

  Future<JSON<T>> getAndCacheData<T>(
    String fullUrl,
    T Function(Map<String, dynamic> json) fromJson, {
    TtlDays ttlDays = TtlDays.defaultDefault,
    // returns true if the data is still valid
    required bool Function(JSON<T> cachedData) extraValidityCheck,
    required String Function(BuildContext context) localizedOfflineMessage,
    VoidCallback? onRetry,
    AuthHeader? authHeader,
  }) async {
    final cacheManager = watch(restCacheManagerProvider(ttlDays));

    final cachedFile = await cacheManager.getFileFromCache(fullUrl);
    if (cachedFile != null) {
      final cachedData = await cachedFile.file.readAsString();
      final data = parseJSON(jsonDecode(cachedData), fromJson);
      if (extraValidityCheck(data)) {
        return data;
      }
    }
    final response = await safeGetWatch<dynamic>(
      fullUrl,
      localizedMessage: localizedOfflineMessage,
      onRetry: onRetry,
      authHeader: authHeader,
    );
    final json = parseJSON(response.data, fromJson);
    if (extraValidityCheck(json)) {
      await cacheManager.putFile(
        fullUrl,
        Uint8List.fromList(utf8.encode(jsonEncode(response.data))),
        fileExtension: CacheManagerConfig.jsonExtesion,
      );
    }
    return json;
  }

  Future<JSON<T>> postAndCacheData<T>(
    String fullUrl,
    T Function(Map<String, dynamic> json) fromJson, {
    TtlDays ttlDays = TtlDays.defaultDefault,
    required bool Function(JSON<T> cachedData) extraValidityCheck,
    required String Function(BuildContext context) localizedOfflineMessage,
    VoidCallback? onRetry,
    AuthHeader? authHeader,
    Object? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final cacheManager = watch(restCacheManagerProvider(ttlDays));
    final cacheKey = fullUrl; 

    final cachedFile = await cacheManager.getFileFromCache(cacheKey);
    if (cachedFile != null) {
      final cachedData = await cachedFile.file.readAsString();
      final data = parseJSON(jsonDecode(cachedData), fromJson);
      if (extraValidityCheck(data)) {
        return data;
      }
    }

    final response = await safePostWatch<dynamic>(
      fullUrl,
      data: body,
      queryParameters: queryParameters,
      localizedMessage: localizedOfflineMessage,
      onRetry: onRetry,
      authHeader: authHeader,
      headers: headers,
    );

    final json = parseJSON(response.data, fromJson);
    if (extraValidityCheck(json)) {
      await cacheManager.putFile(
        cacheKey,
        Uint8List.fromList(utf8.encode(jsonEncode(response.data))),
        fileExtension: CacheManagerConfig.jsonExtesion,
      );
    }
    return json;
  }
}

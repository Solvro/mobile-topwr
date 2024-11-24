import "dart:convert";
import "dart:typed_data";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "../client/dio_client.dart";
import "cache_manager.dart";

extension DataCachingX on Ref{
  Future<T> getAndCacheData<T>(
    String fullUrl,
    int ttlDays,
    T Function(Map<String, dynamic> json) fromJson,
    bool Function() extraValidityCheck,
  ) async {
    final cacheManager = watch(restCacheManagerProvider(ttlDays));

    final cachedFile = await cacheManager.getFileFromCache(fullUrl);
    if (cachedFile != null && extraValidityCheck()) {
      final cachedData = await cachedFile.file.readAsString();
      final data = fromJson(
        jsonDecode(cachedData) as Map<String, dynamic>,
      );
      return data;
    }
    final dio = watch(restClientProvider);
    final response = await dio.get(fullUrl);
    final sksData = fromJson(response.data as Map<String, dynamic>);

    await cacheManager.putFile(
      fullUrl,
      Uint8List.fromList(jsonEncode(response.data).codeUnits),
      fileExtension: CacheManagerConfig.jsonExtesion,
    );

    return sksData;
  }
}

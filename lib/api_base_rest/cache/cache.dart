import "dart:convert";
import "dart:typed_data";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../shared_api_clients/sks_api_client.dart";
import "cache_manager.dart";

Future<T> getAndCacheData<T>(
  String url,
  Ref ref,
  T Function(Map<String, dynamic> json) fromJson,
) async {
  final cacheManager = ref.read(cacheManagerSingletonProvider);

  final cachedFile = await cacheManager.getFileFromCache(url);
  if (cachedFile != null) {
    final cachedData = await cachedFile.file.readAsString();
    final data = fromJson(
      jsonDecode(cachedData) as Map<String, dynamic>,
    );
    return data;
  }
  final dio = ref.read(sksClientProvider);
  final response = await dio.get(url);
  final sksData = fromJson(response.data as Map<String, dynamic>);

  await cacheManager.putFile(
    url,
    Uint8List.fromList(jsonEncode(response.data).codeUnits),
    fileExtension: CacheManagerConfig.jsonExtesion,
  );

  return sksData;
}

import "package:flutter/foundation.dart";
import "package:http_cache_drift_store/http_cache_drift_store.dart";
import "package:path_provider/path_provider.dart" show getTemporaryDirectory;
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/map_view_config.dart";

part "cache.g.dart";

@Riverpod(keepAlive: true)
Future<String> mapCacheDir(Ref ref) async {
  final directory = await getTemporaryDirectory();
  return directory.path;
}

@Riverpod(keepAlive: true)
Future<DriftCacheStore> mapCacheStore(Ref ref) async {
  final directory = kIsWeb ? "<ignore>" : await ref.watch(mapCacheDirProvider.future);
  return DriftCacheStore(databaseName: MapCacheConfig.cacheDatabaseName, databasePath: directory);
}

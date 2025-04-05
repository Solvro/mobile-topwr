import "package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
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
Future<DbCacheStore> mapCacheStore(Ref ref) async {
  final directory = await ref.watch(mapCacheDirProvider.future);
  return DbCacheStore(databaseName: MapCacheConfig.cacheDatabaseName, databasePath: directory);
}

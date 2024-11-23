import "package:flutter_cache_manager/flutter_cache_manager.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "cache_manager.g.dart";

@Riverpod(keepAlive: true)
CacheManager cacheManagerSingleton(Ref ref) {
  return CacheManager(
    CacheManagerConfig.jsonCacheManagerConfig,
  );
}

abstract class CacheManagerConfig {
  static final jsonCacheManagerConfig = Config(
    "JsonCacheManager7Days",
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 10,
  );

  static const jsonExtesion = ".json";
}

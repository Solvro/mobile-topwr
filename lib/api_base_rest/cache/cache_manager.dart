import "package:flutter_cache_manager/flutter_cache_manager.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "cache_manager.g.dart";

@Riverpod(keepAlive: true)
CacheManager restCacheManager(Ref ref, [int ttlDays = 7]) {
  return CacheManager(
    Config("JsonCacheManager${ttlDays}Days", stalePeriod: Duration(days: ttlDays), maxNrOfCacheObjects: 1000),
  );
}

abstract class CacheManagerConfig {
  static const jsonExtesion = "json";
}

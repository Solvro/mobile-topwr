import "package:flutter_cache_manager/flutter_cache_manager.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/ttl_config.dart";

part "cache_manager.g.dart";

@Riverpod(keepAlive: true)
CacheManager restCacheManager(Ref ref, [TtlDays ttlDays = TtlDays.defaultDefault]) {
  return CacheManager(
    Config(
      "NewJsonCacheManager${ttlDays.days}Days",
      stalePeriod: Duration(days: ttlDays.days),
      maxNrOfCacheObjects: 1000,
    ),
  );
}

abstract class CacheManagerConfig {
  static const jsonExtesion = "json";
}

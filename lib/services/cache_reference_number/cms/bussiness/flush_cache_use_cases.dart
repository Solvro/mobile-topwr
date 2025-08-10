import "dart:async";

import "package:flutter_cache_manager/flutter_cache_manager.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../config/ttl_config.dart";
import "../../general/business/flush_cache_use_cases.dart";
import "../data/local_cache_ref_number_repo.dart";
import "../data/remote_cache_ref_number_repo.dart";

extension FlushCacheUseCaseX on WidgetRef {
  Future<void> flushAllCacheIfNeededFromCms() async {
    return flushAllCacheIfNeededByReferenceNumber(
      localCacheRefNumberRepoProvider,
      remoteCacheRefNumberRepoProvider,
      () async {
        for (final ttlDays in TtlDays.values) {
          await clearAllCache(ttlDays);
        }
        await DefaultCacheManager().removeFile(MyCachedImageConfig.cacheKey);
      },
    );
  }
}

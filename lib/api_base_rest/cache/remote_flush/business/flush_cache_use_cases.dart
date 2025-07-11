import "dart:async";

import "package:flutter_cache_manager/flutter_cache_manager.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ttl_config.dart";
import "../../cache.dart";
import "../data/local_cache_ref_number_repo.dart";
import "../data/remote_cache_ref_number_repo.dart";

extension FlushCacheUseCaseX on WidgetRef {
  Future<void> flushAllCacheIfNeeded() async {
    final remoteRefNumber = await watch(remoteCacheRefNumberRepoProvider.future) ?? 0;
    final localRefNumber = await watch(localCacheRefNumberRepoProvider.future) ?? 0;
    if (remoteRefNumber > localRefNumber) {
      for (final ttlDays in TtlDays.values) {
        await clearAllCache(ttlDays);
      }
      await watch(localCacheRefNumberRepoProvider.notifier).saveNumber(remoteRefNumber);
      await DefaultCacheManager().removeFile(MyCachedImageConfig.cacheKey);
    }
  }
}

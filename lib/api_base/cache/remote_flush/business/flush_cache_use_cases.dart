import "dart:async";

import "package:flutter_cache_manager/flutter_cache_manager.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ttl_config.dart";
import "../../ttl/ttl_service.dart";
import "../data/local_cache_ref_number_repo.dart";
import "../data/remote_cache_ref_number_repo.dart";

extension FlushCacheUseCasesX on WidgetRef {
  Future<void> flushAllCacheIfNeeded() async {
    final remoteRefNumber =
        await watch(remoteCacheRefNumberRepoProvider.future) ?? 0;
    final localRefNumber =
        await watch(localCacheRefNumberRepoProvider.future) ?? 0;
    if (remoteRefNumber > localRefNumber) {
      await _flushAll(remoteRefNumber);
    }
    await DefaultCacheManager().removeFile(MyCachedImageConfig.cacheKey);
  }

  Future<void> _flushAll(int remoteRefNumber) async {
    await Future.wait([
      for (final key in TtlKey.values)
        watch(ttlServiceProvider(key).notifier).flushCache(),
    ]);
    await watch(localCacheRefNumberRepoProvider.notifier)
        .saveNumber(remoteRefNumber);
  }
}

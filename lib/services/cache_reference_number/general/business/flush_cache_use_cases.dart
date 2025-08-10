import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";

import "../data/local_number_repository.dart";
import "../data/remote_number_repository.dart";

typedef ClearCacheCallback = Future<void> Function();

extension FlushCacheUseCaseX on WidgetRef {
  Future<void> flushAllCacheIfNeededByReferenceNumber<T extends LocalCacheRefNumberRepositoryMixin>(
    AutoDisposeAsyncNotifierProvider<T, int?> localCacheRefNumberRepoProvider,
    RemoteCacheRefNumberRepositoryType remoteCacheRefNumberRepoProvider,
    ClearCacheCallback clearCacheCallback,
  ) async {
    final remoteRefNumber = await watch(remoteCacheRefNumberRepoProvider.future) ?? 0;
    final localRefNumber = await watch(localCacheRefNumberRepoProvider.future) ?? 0;
    if (remoteRefNumber > localRefNumber) {
      await clearCacheCallback();
      await watch(localCacheRefNumberRepoProvider.notifier).saveNumber(remoteRefNumber);
    }
  }
}

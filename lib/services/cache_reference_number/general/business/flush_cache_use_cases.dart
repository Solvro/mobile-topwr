import "dart:async";

import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/local_number_repository.dart";
import "../data/remote_number_repository.dart";

typedef ClearCacheCallback = Future<void> Function();

extension FlushCacheUseCaseX on WidgetRef {
  Future<void> flushAllCacheIfNeededByReferenceNumber<T extends LocalCacheRefNumberRepositoryMixin>(
    BuildContext context,
    $AsyncNotifierProvider<T, int?> localCacheRefNumberRepoProvider,
    RemoteCacheRefNumberRepositoryType remoteCacheRefNumberRepoProvider,
    ClearCacheCallback clearCacheCallback,
  ) async {
    final remoteRefNumber = await read(remoteCacheRefNumberRepoProvider.future) ?? 0;
    if (!context.mounted) return;
    final localRefNumber = await read(localCacheRefNumberRepoProvider.future) ?? 0;
    if (!context.mounted) return;
    if (remoteRefNumber > localRefNumber) {
      await clearCacheCallback();
      if (!context.mounted) return;
      await read(localCacheRefNumberRepoProvider.notifier).saveNumber(remoteRefNumber);
    }
  }
}

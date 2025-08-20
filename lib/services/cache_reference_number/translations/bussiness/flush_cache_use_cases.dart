import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../translations_service/business/flush_cache_drift_use_cases.dart";
import "../../general/business/flush_cache_use_cases.dart";
import "../data/local_cache_ref_number_repo.dart";
import "../data/remote_cache_ref_number_repo.dart";

extension FlushTranslatorCacheUseCaseX on WidgetRef {
  Future<void> flushTranslationsCacheIfNeededFromRemote() {
    return flushAllCacheIfNeededByReferenceNumber(
      localTranslatorRefNumberRepoProvider,
      remoteTranslatorRefNumberRepoProvider,
      () async {
        await clearTranslationsCache();
      },
    );
  }
}

import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/translations_config.dart";
import "solvro_translator.dart";

extension FlushCacheDriftUseCases on WidgetRef {
  Future<void> flushOldData() async {
    final translator = watch(solvroTranslatorProvider);
    await translator.flushOldData(TranslationsConfig.ttl);
  }

  Future<void> clearTranslationsCache() async {
    final translator = watch(solvroTranslatorProvider);
    await translator.localTranslatableManager.clearTranslations();
  }
}

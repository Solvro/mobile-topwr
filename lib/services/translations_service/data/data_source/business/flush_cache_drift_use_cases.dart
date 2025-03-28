import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/translations_config.dart";
import "../local/database/translation_db_singleton.dart";

extension FlushCacheDriftUseCases on WidgetRef {
  Future<void> flushOldData() async {
    final db = watch(translationsDatabaseSingletonProvider);
    await db.deleteOldTranslations(TranslationsConfig.ttl);
  }
}

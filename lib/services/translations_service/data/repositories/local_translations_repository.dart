import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../data_source/local/database/translation_db_singleton.dart";
import "../models/translation.dart";

class LocalTranslationsRepository extends LocalTranslatableManager<TranslationWithInterface, TranslationResponse> {
  final Ref ref;

  const LocalTranslationsRepository(this.ref);

  @override
  Future<TranslationWithInterface?> getTranslation(int hash, SolvroLocale locale) async {
    final db = ref.read(translationsDatabaseSingletonProvider);
    final translation = await db.getTranslation(hash, locale);
    if (translation == null) return null;
    return TranslationWithInterface.fromTranslation(translation);
  }

  @override
  Future<void> saveTranslation(TranslationResponse translation) async {
    final db = ref.read(translationsDatabaseSingletonProvider);
    await db.addTranslation(translation.getTranslation());
  }
}

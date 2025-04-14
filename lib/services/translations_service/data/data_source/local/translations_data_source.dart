import "package:solvro_translator_core/solvro_translator_core.dart";

import "database/translations_database.dart";

abstract interface class TranslationsDataSource {
  factory TranslationsDataSource() = TranslationsDatabase;

  Future<Translation?> getTranslation(int hash, SolvroLocale translatedLangCode);

  Future<int> addTranslation(Translation translation);

  Future<int> deleteOldTranslations(Duration duration);

  Future<int> clearTranslations();
}

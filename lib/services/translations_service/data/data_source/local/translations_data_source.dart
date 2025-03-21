import "../../models/supported_languages.dart";
import "database/translations_database.dart";

abstract interface class TranslationsDataSource {
  factory TranslationsDataSource() = TranslationsDatabase;

  Future<Translation?> getTranslation(int hash, SupportedLocales translatedLangCode);

  Future<int> addTranslation(Translation translation);

  Future<int> deleteOldTranslations(Duration duration);

  Future<int> clearTranslations();
}

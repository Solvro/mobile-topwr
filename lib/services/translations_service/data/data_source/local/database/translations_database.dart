import "package:drift/drift.dart";
import "package:drift_flutter/drift_flutter.dart";

import "../../../models/supported_languages.dart";
import "../../../models/translation.dart";
import "../translations_data_source.dart";

part "translations_database.g.dart";

@DriftDatabase(tables: [Translations])
class TranslationsDatabase extends _$TranslationsDatabase implements TranslationsDataSource {
  TranslationsDatabase() : super(driftDatabase(name: "translations_database"));

  @override
  int get schemaVersion => 1;

  @override
  Future<Translation?> getTranslation(int hash, SupportedLocales translatedLangCode) async {
    return (select(translations)..where(
      (t) => t.originalTextHash.equals(hash) & t.translatedLanguageCode.equals(translatedLangCode.index),
    )).getSingleOrNull();
  }

  @override
  Future<int> addTranslation(Translation translation) async {
    return into(translations).insert(translation, mode: InsertMode.insertOrReplace);
  }

  @override
  Future<int> deleteOldTranslations(Duration duration) async {
    final DateTime thresholdDate = DateTime.now().subtract(duration);
    return (delete(translations)..where((t) => t.createdAt.isSmallerThanValue(thresholdDate))).go();
  }

  @override
  Future<int> clearTranslations() async {
    return delete(translations).go();
  }
}

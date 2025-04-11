import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../config/shared_prefs.dart";
import "../../../../config/translations_config.dart";
import "../models/supported_languages.dart";

part "preferred_lang_repository.g.dart";

@riverpod
class PreferredLanguageRepository extends _$PreferredLanguageRepository {
  @override
  Future<SupportedLocales> build() async {
    final sharedPreferences = await ref.watch(sharedPreferencesSingletonProvider.future);
    final languageCode = sharedPreferences.getString(TranslationsConfig.localesKey) ?? SupportedLocales.pl.name;
    return SupportedLocales.fromString(languageCode);
  }

  Future<void> setPreferredLanguage(SupportedLocales localeCode) async {
    final sharedPreferences = await ref.watch(sharedPreferencesSingletonProvider.future);
    await sharedPreferences.setString(TranslationsConfig.localesKey, localeCode.name);
  }
}

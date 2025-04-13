import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:translatable_generator/index.dart";

import "../../../../config/shared_prefs.dart";
import "../../../../config/translations_config.dart";

part "preferred_lang_repository.g.dart";

@riverpod
class PreferredLanguageRepository extends _$PreferredLanguageRepository {
  @override
  Future<SolvroLocale> build() async {
    final sharedPreferences = await ref.watch(sharedPreferencesSingletonProvider.future);
    final languageCode = sharedPreferences.getString(TranslationsConfig.localesKey) ?? SolvroLocale.pl.name;
    return SolvroLocale.values.byName(languageCode);
  }

  Future<void> setPreferredLanguage(SolvroLocale localeCode) async {
    final sharedPreferences = await ref.read(sharedPreferencesSingletonProvider.future);
    await sharedPreferences.setString(TranslationsConfig.localesKey, localeCode.name);
  }
}

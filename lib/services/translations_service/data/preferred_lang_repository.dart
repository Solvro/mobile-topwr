import "dart:async";

import "package:clarity_flutter/clarity_flutter.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../config/shared_prefs.dart";
import "../../../../config/translations_config.dart";
import "../../../features/analytics/data/clarity.dart";
import "../../../features/analytics/data/clarity_events.dart";

part "preferred_lang_repository.g.dart";

@riverpod
class PreferredLanguageRepository extends _$PreferredLanguageRepository {
  @override
  Future<SolvroLocale?> build() async {
    final sharedPreferences = await ref.watch(sharedPreferencesSingletonProvider.future);
    final languageCode = sharedPreferences.getString(TranslationsConfig.localesKey);
    if (languageCode == null) {
      return null;
    }
    final locale = SolvroLocale.values.byName(languageCode);
    Clarity.setCustomTags("language", [locale.name]);
    return locale;
  }

  Future<void> setPreferredLanguage(SolvroLocale localeCode) async {
    state = AsyncData(localeCode);
    unawaited(ref.trackEvent(ClarityEvents.changeLanguage, value: localeCode.name));
    Clarity.setCustomTags("language", [localeCode.name]);
    final sharedPreferences = await ref.read(sharedPreferencesSingletonProvider.future);
    await sharedPreferences.setString(TranslationsConfig.localesKey, localeCode.name);
  }
}

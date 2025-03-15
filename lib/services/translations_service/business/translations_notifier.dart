import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/shared_prefs.dart";
import "../models/supported_languages.dart";

part "translations_notifier.g.dart";

@riverpod
class Translations extends _$Translations {
  static const localesKey = "locales_preference";

  @override
  Future<SupportedLocales> build() async {
    final sharedPreferences = await ref.watch(sharedPreferencesSingletonProvider.future);

    final localeString = sharedPreferences.getString(localesKey);

    if (localeString == null) {
      return SupportedLocales.en;
    }

    return SupportedLocales.fromString(localeString);
  }

  Future<void> changeLocale(SupportedLocales locale) async {
    final sharedPreferences = await ref.watch(sharedPreferencesSingletonProvider.future);

    await sharedPreferences.setString(localesKey, locale.name);
    state = AsyncData(locale);
  }
}

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../config/shared_prefs.dart";
import "../../../../config/translations_config.dart";
import "../../business/translations_notifier.dart";
import "../data_source/local/database/translation_db_singleton.dart";
import "../data_source/remote/translation_client.dart";
import "../models/supported_languages.dart";
import "../models/translation.dart";

part "translations_repository.g.dart";

@riverpod
Future<String> translationsRepository(Ref ref, String originalText) async {
  final db = ref.watch(translationsDatabaseSingletonProvider);
  final locale = await ref.watch(translationsProvider.future);

  if (locale == SupportedLocales.pl || originalText.trim().isEmpty || !RegExp("[a-zA-Z0-9]").hasMatch(originalText)) {
    return originalText;
  }

  final translation = await db.getTranslation(originalText.hashCode, locale);
  if (translation != null) return translation.translatedText;

  final dio = ref.watch(translationsClientProvider);

  final request = TranslationRequest(
    originalText: originalText,
    originalLanguageCode: SupportedLocales.pl.name,
    translatedLanguageCode: locale.name,
  );

  final response = await dio.post<Map<String, dynamic>>("/translations/openAI", data: request.toJson());

  final translationModel = TranslationResponse.fromJson(response.data!).getTranslation();
  await db.addTranslation(translationModel);

  return translationModel.translatedText;
}

@riverpod
Future<void> setPrefferedLanguage(Ref ref, SupportedLocales localeCode) async {
  final sharedPreferences = await ref.watch(sharedPreferencesSingletonProvider.future);

  await sharedPreferences.setString(TranslationsConfig.localesKey, localeCode.name);
}

@riverpod
Future<SupportedLocales> fetchPrefferedLanguage(Ref ref) async {
  final sharedPreferences = await ref.watch(sharedPreferencesSingletonProvider.future);

  final languageCode = sharedPreferences.getString(TranslationsConfig.localesKey) ?? SupportedLocales.pl.name;

  return SupportedLocales.fromString(languageCode);
}

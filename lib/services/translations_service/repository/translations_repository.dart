import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/env.dart";
import "../business/translations_notifier.dart";
import "../client/translation_client.dart";
import "../models/supported_languages.dart";
import "../models/translation.dart";

part "translations_repository.g.dart";

@riverpod
Future<String> translationsRepository(Ref ref, String originalText) async {
  final dio = ref.watch(translationsClientProvider);
  final locale = await ref.watch(translationsProvider.future);

  if (locale == SupportedLocales.pl) {
    return originalText;
  }

  final request = TranslationRequest(
    originalText: originalText,
    originalLanguageCode: SupportedLocales.pl.name,
    translatedLanguageCode: locale.name,
  );

  final response = await dio.post<Map<String, dynamic>>(
    "${Env.translateApiUrl}/translations/openAI",
    data: request.toJson(),
  );

  final translation = Translation.fromJson(response.data!);

  return translation.translatedText;
}

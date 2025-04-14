import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:solvro_translator_core/solvro_translator_core.dart" show RemoteTranslatableManager, SolvroLocale;

import "../data_source/remote/translation_client.dart";
import "../models/translation.dart";

class RemoteTranslationsRepository extends RemoteTranslatableManager<TranslationResponse> {
  final Ref ref;

  const RemoteTranslationsRepository(this.ref);

  @override
  Future<TranslationResponse> translate(String originalText, SolvroLocale from, SolvroLocale to) async {
    if (from != SolvroLocale.pl) {
      throw ArgumentError("Only PL is supported as source language");
    }
    final request = TranslationRequest(
      originalText: originalText,
      originalLanguageCode: SolvroLocale.pl.name,
      translatedLanguageCode: to.name,
    );
    final dio = ref.read(translationsClientProvider);
    final response = await dio.post<Map<String, dynamic>>("/translations/openAI", data: request.toJson());

    return TranslationResponse.fromJson(response.data!);
  }
}

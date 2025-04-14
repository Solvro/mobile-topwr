import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../data_source/local/database/translation_db_singleton.dart";
import "../data_source/remote/translation_client.dart";
import "../models/translation.dart";

part "translations_repository.g.dart";

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

class LocalTranslationsRepository extends LocalTranslatableManager<TranslationWithInterface, TranslationResponse> {
  final Ref ref;

  const LocalTranslationsRepository(this.ref);

  @override
  Future<TranslationWithInterface?> getTranslation(int hash, SolvroLocale locale) async {
    final db = ref.read(translationsDatabaseSingletonProvider);
    final translation = await db.getTranslation(hash, locale);
    if (translation == null) return null;
    return TranslationWithInterface.fromTranslation(translation);
  }

  @override
  Future<void> saveTranslation(TranslationResponse translation) async {
    final db = ref.read(translationsDatabaseSingletonProvider);
    await db.addTranslation(translation.getTranslation());
  }
}

@riverpod
SolvroTranslator<TranslationWithInterface, TranslationResponse> solvroTranslator(Ref ref) {
  return SolvroTranslator.init(
    localTranslatableManager: LocalTranslationsRepository(ref),
    remoteTranslatableManager: RemoteTranslationsRepository(ref),
    validityCheck: (translation) => translation.translatedText.isNotEmpty,
    sourceLocale: SolvroLocale.pl,
  );
}

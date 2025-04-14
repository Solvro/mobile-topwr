import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../data/models/translation.dart";
import "../data/repositories/local_translations_repository.dart";
import "../data/repositories/remote_translations_repository.dart";

part "translator_provider.g.dart";

@riverpod
SolvroTranslator<TranslationWithInterface, TranslationResponse> solvroTranslator(Ref ref) {
  return SolvroTranslator.init(
    localTranslatableManager: LocalTranslationsRepository(ref),
    remoteTranslatableManager: RemoteTranslationsRepository(ref),
    validityCheck: (translation) => translation.translatedText.isNotEmpty,
    sourceLocale: SolvroLocale.pl,
  );
}

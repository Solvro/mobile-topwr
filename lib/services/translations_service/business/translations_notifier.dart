import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/models/supported_languages.dart";
import "../data/repositories/preferred_lang_repository.dart";

part "translations_notifier.g.dart";

@riverpod
class Translations extends _$Translations {
  @override
  Future<SupportedLocales> build() async => await ref.watch(preferredLanguageRepositoryProvider.future);

  Future<void> setLocale(SupportedLocales locale) async {
    await ref.read(preferredLanguageRepositoryProvider.notifier).setPreferredLanguage(locale);
    state = AsyncData(locale);
  }
}

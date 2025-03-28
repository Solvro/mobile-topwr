import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/models/supported_languages.dart";
import "../data/repository/translations_repository.dart";

part "translations_notifier.g.dart";

@riverpod
class Translations extends _$Translations {
  @override
  Future<SupportedLocales> build() async => await ref.watch(fetchPrefferedLanguageProvider.future);

  Future<void> setLocale(SupportedLocales locale) async {
    await ref.read(setPrefferedLanguageProvider(locale).future);
    state = AsyncData(locale);
  }
}

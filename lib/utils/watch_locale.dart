import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../l10n/app_localizations.dart";
import "../services/translations_service/data/preferred_lang_repository.dart";

part "watch_locale.g.dart";

@riverpod
AppLocalizations watchLocale(Ref ref) {
  final preferredLang = ref.watch(preferredLanguageRepositoryProvider);
  final langCode = preferredLang.value?.name ?? SolvroLocale.pl.name;
  final supportedLocale = AppLocalizations.supportedLocales.firstWhere(
    (supported) => supported.languageCode == langCode,
    orElse: () => AppLocalizations.supportedLocales.first,
  );
  return lookupAppLocalizations(supportedLocale);
}

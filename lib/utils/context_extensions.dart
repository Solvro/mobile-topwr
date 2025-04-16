import "package:flutter/material.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../l10n/app_localizations.dart";
import "../l10n/app_localizations_pl.dart";

extension BuildContextX on BuildContext {
  AppLocalizations get localize {
    return AppLocalizations.of(this) ?? AppLocalizationsPl();
  }

  Locale get locale => Localizations.localeOf(this);

  SolvroLocale get solvroLocale => SolvroLocale.values.byName(locale.languageCode);

  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}

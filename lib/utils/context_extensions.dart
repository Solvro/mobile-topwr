import "package:flutter/material.dart";

import "../l10n/app_localizations.dart";
import "../l10n/app_localizations_pl.dart";

extension BuildContextX on BuildContext {
  AppLocalizations get localize {
    return AppLocalizations.of(this) ?? AppLocalizationsPl();
  }

  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}

import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_gen/gen_l10n/app_localizations_pl.dart";

extension BuildContextShortcutExtension on BuildContext {
  AppLocalizations get localize {
    return AppLocalizations.of(this) ?? AppLocalizationsPl();
  }

  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}

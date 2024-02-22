import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextShortcutExtension on BuildContext {
  AppLocalizations? get localize {
    return AppLocalizations.of(this);
  }

  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}

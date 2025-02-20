import "dart:ui";

import "package:flutter/widgets.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../l10n/app_localizations.dart";

part "watch_locale.g.dart";

@riverpod
class WatchLocale extends _$WatchLocale {
  @override
  AppLocalizations build() {
    final observer = _LocaleObserver(updateLocale);
    WidgetsBinding.instance.addObserver(observer);
    ref.onDispose(() => WidgetsBinding.instance.removeObserver(observer));
    return _getCurrLocal;
  }

  void updateLocale(List<Locale>? _) {
    state = _getCurrLocal;
  }

  static AppLocalizations get _getCurrLocal {
    var locale = PlatformDispatcher.instance.locale;
    if (!AppLocalizations.supportedLocales.contains(locale)) {
      // TODO(simon-the-shark): Add english as default locale (when there is one).
      locale = AppLocalizations.supportedLocales.first;
    }
    return lookupAppLocalizations(locale);
  }
}

class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);

  final void Function(List<Locale>? locales) _didChangeLocales;
  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}

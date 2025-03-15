import "package:flutter/rendering.dart";

enum SupportedLocales {
  pl,
  en;

  Locale toLocale() {
    return Locale(name);
  }

  factory SupportedLocales.fromString(String locale) {
    return SupportedLocales.values.firstWhere((e) => e.name == locale, orElse: () => SupportedLocales.pl);
  }
}

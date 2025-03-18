import "package:flutter/rendering.dart";

enum SupportedLocales {
  pl,
  en;

  Locale toLocale() => Locale(name);

  factory SupportedLocales.fromString(String locale) =>
     SupportedLocales.values.firstWhere((e) => e.name == locale, orElse: () => SupportedLocales.pl);
}

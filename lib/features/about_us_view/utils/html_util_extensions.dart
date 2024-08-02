import "package:flutter/material.dart";
import "package:html/dom.dart" as html;

import "../../../theme/app_theme.dart";
import "../../../theme/hex_color.dart";

extension ToHtmlColorStringX on HexColor {
  String get htmlFormat =>
      '#${value.toRadixString(16).padLeft(8, '0').substring(2)}';
}

extension IsLinkTagX on html.Element {
  bool get isLink {
    return localName == "a";
  }
}

extension CustomHtmlStylesX on BuildContext {
  Map<String, String>? customStylesBuilder(html.Element element) {
    final defaultStyles = {
      "text-align": "justify",
    };
    if (element.isLink) {
      defaultStyles.addAll({
        "color": colorTheme.orangePomegranade.htmlFormat,
        "text-decoration": "none",
      });
    }
    return defaultStyles;
  }
}

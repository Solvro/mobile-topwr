import "package:flutter/material.dart";
// unfortunetly it's a dependency of dependency and it's not re-exported
// ignore: depend_on_referenced_packages
import "package:html/dom.dart" as html;
import "../../../../../theme/app_theme.dart";
import "../../../../../theme/hex_color.dart";

extension ToHtmlColorString on HexColor {
  String get htmlFormat =>
      '#${value.toRadixString(16).padLeft(8, '0').substring(2)}';
}

extension IsLinkTag on html.Element {
  bool get isLink {
    return localName == "a";
  }
}

extension CustomHtmlStyles on BuildContext {
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

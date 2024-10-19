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

  bool get isH1 {
    return localName == "h1";
  }

  bool get hasTextAlign {
    return outerHtml.contains("text-align");
  }
}

extension CustomHtmlStylesX on BuildContext {
  Map<String, String>? customStylesBuilder(html.Element element) {
    return {
      if (!element.hasTextAlign) "text-align": "left",
      if (element.isH1) "font-size": "20px",
      if (element.isLink) "color": colorTheme.orangePomegranade.htmlFormat,
      "text-decoration-color": colorTheme.orangePomegranade.htmlFormat,
    };
  }
}

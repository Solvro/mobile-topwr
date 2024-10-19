import "package:flutter/material.dart";
import "package:html/dom.dart" as html;

import "../../../theme/app_theme.dart";
import "../../../theme/hex_color.dart";

extension ToHtmlColorStringX on HexColor {
  String get htmlFormat =>
      '#${r.toInt().toRadixString(16).padLeft(2, '0')}${g.toInt().toRadixString(16).padLeft(2, '0')}${b.toInt().toRadixString(16).padLeft(2, '0')}';
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

  bool get hasUnderline {
    return outerHtml.contains("text-decoration: underline");
  }
}

extension CustomHtmlStylesX on BuildContext {
  Map<String, String>? customStylesBuilder(html.Element element) {
    return {
      if (!element.hasTextAlign) "text-align": "left",
      if (element.isH1) "font-size": "20px",
      if (element.isLink) "color": colorTheme.orangePomegranade.htmlFormat,
      "text-decoration-color": colorTheme.orangePomegranade.htmlFormat,
      if (element.hasUnderline) "text-decoration-color": colorTheme.blackMirage.htmlFormat,
    };
  }
}

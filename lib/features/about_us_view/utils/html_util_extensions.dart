import "package:flutter/material.dart";
import "package:html/dom.dart" as html;

import "../../../theme/app_theme.dart";

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
      if (element.isLink) "color": colorTheme.orangePomegranade.hexString,
      "text-decoration-color": colorTheme.orangePomegranade.hexString,
      if (element.hasUnderline) "text-decoration-color": colorTheme.blackMirage.hexString,
    };
  }
}

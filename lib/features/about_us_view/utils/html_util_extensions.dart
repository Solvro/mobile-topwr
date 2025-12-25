import "package:flutter/material.dart";
import "package:html/dom.dart" as html;

import "../../../theme/app_theme.dart";
import "../../../theme/hex_color.dart";

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

extension CustomHtmlX on BuildContext {
  Map<String, String>? customStylesBuilder(html.Element element) {
    return {
      if (!element.hasTextAlign) "text-align": "left",
      if (element.isH1) "font-size": "20px",
      if (element.isLink) "color": colorScheme.primary.hexString,
      "text-decoration-color": colorScheme.primary.hexString,
      if (element.hasUnderline) "text-decoration-color": colorScheme.onTertiary.hexString,
    };
  }
}

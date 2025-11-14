import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart";
import "package:html/dom.dart" as html;
import "../../../theme/app_theme.dart";
import "../../../utils/launch_url_util.dart";

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
      if (element.isLink) "color": colorTheme.orangePomegranade.hexString,
      "text-decoration-color": colorTheme.orangePomegranade.hexString,
      if (element.hasUnderline) "text-decoration-color": colorTheme.blackMirage.hexString,
    };
  }

  Widget? customWidgetBuilder(html.Element element, WidgetRef ref, TextStyle textStyle) {
    if (element.isLink) {
      final href = element.attributes["href"] ?? "";
      final linkText = element.text.trim();

      return InlineCustomWidget(
        child: Semantics(
          link: true,
          onTap: () async {
            if (href.isNotEmpty) {
              await ref.launch(href);
            }
          },
          child: GestureDetector(
            onTap: () async {
              if (href.isNotEmpty) {
                await ref.launch(href);
              }
            },
            child: Text(
              linkText,
              style: textStyle.copyWith(
                color: colorTheme.orangePomegranade,
                decorationColor: colorTheme.orangePomegranade,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      );
    }
    return null;
  }
}

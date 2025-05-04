import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart";

import "../features/about_us_view/utils/html_util_extensions.dart";
import "../theme/app_theme.dart";
import "../utils/html_to_plain_text.dart";
import "../utils/launch_url_util.dart";

/// Widget that renders HTML. Supports semantics for screen readers and custom ToPWR styling.

class MyHtmlWidget extends ConsumerWidget {
  const MyHtmlWidget(this.html, {super.key, this.textStyle});
  final String html;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: html.parseHtmlString(),
      child: ExcludeSemantics(
        child: HtmlWidget(
          html,
          textStyle: textStyle ?? context.aboutUsTheme.body,
          customStylesBuilder: context.customStylesBuilder,
          onTapUrl: ref.launch,
        ),
      ),
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart";

import "../features/about_us_view/utils/html_util_extensions.dart";
import "../theme/app_theme.dart";
import "../utils/launch_url_util.dart";

class MyHtmlWidget extends ConsumerWidget {
  const MyHtmlWidget(this.html, {super.key, this.textStyle});
  final String html;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HtmlWidget(
      html,
      textStyle: textStyle ?? context.aboutUsTheme.body,
      customStylesBuilder: context.customStylesBuilder,
      onTapUrl: ref.launch,
    );
  }
}

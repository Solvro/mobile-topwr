import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/launch_url_util.dart";
import "../utils/html_util_extensions.dart";

class DescriptionSection extends ConsumerWidget {
  const DescriptionSection({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AboutUsConfig.defaultPadding),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AboutUsConfig.borderRadius),
          color: context.colorTheme.greyLight,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AboutUsConfig.defaultPadding),
          child: HtmlWidget(
            text,
            textStyle: context.aboutUsTheme.body,
            customStylesBuilder: context.customStylesBuilder,
            onTapUrl: ref.launch,
          ),
        ),
      ),
    );
  }
}

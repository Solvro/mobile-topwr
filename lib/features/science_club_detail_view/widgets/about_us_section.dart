import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/launch_url_util.dart";
import "../../about_us_view/utils/html_util_extensions.dart";

class AboutUsSection extends ConsumerWidget {
  const AboutUsSection({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return text.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(24).copyWith(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localize.about_us,
                  style: context.textTheme.headline,
                ),
                const SizedBox(height: 16),
                HtmlWidget(
                  text,
                  textStyle: context.aboutUsTheme.body,
                  customStylesBuilder: context.customStylesBuilder,
                  onTapUrl: ref.launch,
                ),
              ],
            ),
          );
  }
}

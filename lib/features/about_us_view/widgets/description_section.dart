import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/my_html_widget.dart";

class DescriptionSection extends ConsumerWidget {
  const DescriptionSection({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AboutUsConfig.defaultPadding),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AboutUsConfig.borderRadius),
          color: context.colorTheme.greyLight,
        ),
        child: Padding(padding: const EdgeInsets.all(AboutUsConfig.defaultPadding), child: MyHtmlWidget(text)),
      ),
    );
  }
}

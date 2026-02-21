import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_html_widget.dart";

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
                Text(context.localize.about_us, style: context.textTheme.headlineMedium),
                const SizedBox(height: 16),
                MyHtmlWidget(text),
              ],
            ),
          );
  }
}

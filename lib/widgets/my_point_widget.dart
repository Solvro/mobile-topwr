import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../config/ui_config.dart";
import "../services/translations_service/widgets/rich_text_with_translation.dart";
import "../theme/app_theme.dart";

class MyPointWidget extends ConsumerWidget {
  const MyPointWidget({required this.text});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.heightTiny / 2),
      child: RichTextWithTranslation(
        text: TextSpan(
          text: "• ",
          style: context.textTheme.body.copyWith(fontSize: 18),
          children: [TextSpan(text: text, style: context.textTheme.body.copyWith(fontSize: 14))],
        ),
        maxLines: 100,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

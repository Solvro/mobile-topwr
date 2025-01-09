import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../config/ui_config.dart";
import "../theme/app_theme.dart";

class MyPointWidget extends ConsumerWidget {
  const MyPointWidget({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: DigitalGuideConfig.heightSmall),
          child: Text(
            "•",
            style: context.textTheme.title.copyWith(fontSize: 24),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: DigitalGuideConfig.heightSmall),
            child: Text(
              text,
              style: context.textTheme.body.copyWith(fontSize: 16),
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

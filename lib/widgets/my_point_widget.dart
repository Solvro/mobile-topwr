import "package:flutter/material.dart";

import "../config/ui_config.dart";
import "../theme/app_theme.dart";

class MyPointWidget extends StatelessWidget {
  const MyPointWidget({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: DigitalGuideConfig.heightSmall),
          child: Text(
            "•",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

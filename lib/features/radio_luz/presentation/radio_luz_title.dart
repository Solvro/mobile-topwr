import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";

class RadioLuzTitle extends StatelessWidget {
  const RadioLuzTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: RadioLuzConfig.horizontalBasePadding),
      child: Row(
        spacing: 8,
        children: [
          Text(title, style: context.textTheme.megaBigHeadline),
          Expanded(child: Divider(color: context.colorTheme.orangePomegranade, thickness: 2)),
        ],
      ),
    );
  }
}

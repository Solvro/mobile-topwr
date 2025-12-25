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
          Focus(autofocus: true, child: Text(title, style: context.textTheme.displayLarge)),
          Expanded(child: Divider(color: context.colorScheme.primary, thickness: 2)),
        ],
      ),
    );
  }
}

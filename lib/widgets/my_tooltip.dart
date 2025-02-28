import "package:flutter/material.dart";

import "../config/ui_config.dart";
import "../theme/app_theme.dart";

class MyTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final bool preferBelow;
  const MyTooltip({required this.message, required this.child, this.preferBelow = false});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      richMessage: TextSpan(text: message, style: context.textTheme.body),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MyTooltipConfig.borderRadius),
        color: context.colorTheme.whiteSoap,
        boxShadow: MyTooltipConfig.defaultActiveShadows,
      ),
      preferBelow: preferBelow,
      child: child,
    );
  }
}

import "package:flutter/material.dart";

import "../config/ui_config.dart";
import "../theme/app_theme.dart";

class MySplashTile extends StatelessWidget {
  const MySplashTile({super.key, required this.child, this.onTap, this.backgroundColor, this.focusNode});

  final Widget child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
      child: InkWell(
        focusNode: focusNode,
        borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor ?? context.colorScheme.surfaceTint,
            borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          ),
          child: child,
        ),
      ),
    );
  }
}

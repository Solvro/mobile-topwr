import "package:flutter/material.dart";

import "../config/ui_config.dart";
import "../theme/app_theme.dart";

class MySplashTile extends StatelessWidget {
  const MySplashTile({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
      child: InkWell(
        borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: context.colorTheme.greyLight,
            borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          ),
          child: child,
        ),
      ),
    );
  }
}

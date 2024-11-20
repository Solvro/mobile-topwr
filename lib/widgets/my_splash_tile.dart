import "package:flutter/material.dart";

import "../config/ui_config.dart";
import "../theme/app_theme.dart";

class MySplashTile extends StatelessWidget {
  const MySplashTile({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: context.colorTheme.greyLight,
              borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
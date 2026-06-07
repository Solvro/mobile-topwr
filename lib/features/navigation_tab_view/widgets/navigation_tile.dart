import "dart:async";

import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../services/haptics/app_haptics.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/my_splash_tile.dart";

class NavigationTile extends StatelessWidget {
  const NavigationTile({super.key, required this.title, this.icon, this.onTap});

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return MySplashTile(
      onTap: onTap == null
          ? null
          : () {
              unawaited(AppHaptics.selectionClick());
              onTap!();
            },
      child: SizedBox(
        child: DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(NavigationTabViewConfig.radius)),
          child: ListTile(
            dense: true,
            leading: icon != null ? Icon(icon, semanticLabel: "") : null,
            title: Text(title, style: context.textTheme.titleLarge?.copyWith(height: 1)),
            trailing: Icon(Icons.chevron_right, semanticLabel: "", color: context.colorScheme.primary),
          ),
        ),
      ),
    );
  }
}

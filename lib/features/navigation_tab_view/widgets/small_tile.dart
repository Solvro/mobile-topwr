import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/my_splash_tile.dart";

class SmallTileCard extends StatelessWidget {
  const SmallTileCard({
    required this.title,
    required this.icon,
    this.onTap,
    super.key,
  });

  final String title;
  final VoidCallback? onTap;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return MySplashTile(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: WideTileCardConfig.imageSize / 3 * 2,
            height: WideTileCardConfig.imageSize,
            child: icon,
          ),
          Expanded(
            child: Text(
              title,
              style: context.textTheme.title,
            ),
          ),
          const SizedBox(width: NavigationTabViewConfig.universalPadding),
        ],
      ),
    );
  }
}

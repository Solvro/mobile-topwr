import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";

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
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

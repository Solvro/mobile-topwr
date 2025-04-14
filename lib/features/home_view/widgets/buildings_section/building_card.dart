import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../widgets/optimized_directus_image.dart";
import "../../../../widgets/tile_splash.dart";

class BuildingCard extends StatelessWidget {
  const BuildingCard({super.key, required this.onTap, required this.buildingName, this.directusImageUrl});

  final VoidCallback onTap;
  final String buildingName;
  final String? directusImageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            OptimizedDirectusImage(directusImageUrl),
            if (directusImageUrl != null)
              Positioned.fill(
                child: Container(decoration: BoxDecoration(gradient: context.colorTheme.buildingsGradient)),
              ),
            Container(
              margin: const EdgeInsets.only(left: 16, top: 84),
              child: Text(
                buildingName,
                style: context.textTheme.headlineWhite.copyWith(shadows: HomeViewConfig.squareCardTextShadow),
              ),
            ),
            TileSplash(onTap: onTap),
          ],
        ),
      ),
    );
  }
}

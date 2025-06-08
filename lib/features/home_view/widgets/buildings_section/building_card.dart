import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/optimized_directus_image.dart";
import "../../../../widgets/tile_splash.dart";

class BuildingCard extends StatelessWidget {
  const BuildingCard({super.key, required this.onTap, required this.buildingName, this.directusImageUrl});

  final VoidCallback onTap;
  final String buildingName;
  final String? directusImageUrl;

  @override
  Widget build(BuildContext context) {
    const initialBottomPadding = 6.0;
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
            Positioned(
              bottom: context.isTextScaledDown ? initialBottomPadding / context.textScaleFactor : initialBottomPadding,
              left: 16,
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

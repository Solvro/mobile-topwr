import "package:flutter/material.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../theme/colors.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/rest_api_image.dart";
import "../../../../widgets/tile_splash.dart";

class BuildingCard extends StatelessWidget {
  const BuildingCard({super.key, required this.onTap, required this.buildingName, this.imageData});

  final VoidCallback onTap;
  final String buildingName;
  final ImageData? imageData;

  @override
  Widget build(BuildContext context) {
    const initialBottomPadding = 6.0;
    return Semantics(
      label: "${context.localize.building_prefix} $buildingName",
      button: true,
      child: ExcludeSemantics(
        child: SizedBox(
          width: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (imageData != null) RestApiImage(imageData) else const RestApiImage(null),
                if (imageData != null)
                  Positioned.fill(
                    child: Container(decoration: const BoxDecoration(gradient: ColorsConsts.buildingsGradient)),
                  ),
                Positioned(
                  bottom: context.isTextScaledDown
                      ? initialBottomPadding / context.textScaleFactor
                      : initialBottomPadding,
                  left: 16,
                  child: Text(
                    buildingName,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.colorScheme.surface,
                      shadows: HomeViewConfig.squareCardTextShadow,
                    ),
                  ),
                ),
                TileSplash(onTap: onTap),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

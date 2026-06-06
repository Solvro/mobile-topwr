import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/loading_widgets/shimmer_loading.dart";
import "../../../../widgets/loading_widgets/simple_previews/preview_text_prototype.dart";
import "booth_tile.dart";

class BoothTileLoading extends StatelessWidget {
  const BoothTileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 2);

    return Shimmer(
      linearGradient: shimmerGradient,
      child: Container(
        height: scaler.scale(BoothTileConfig.height),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          color: context.colorScheme.surfaceContainerHighest,
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          border: Border.all(color: context.colorScheme.outlineVariant, width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.92),
                    context.colorScheme.surface.withValues(alpha: 0.72),
                  ],
                ),
              ),
              child: const SizedBox.expand(),
            ),
            Padding(
              padding: ParkingsConfig.padding.copyWith(right: scaler.scale(118), bottom: scaler.scale(16)),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerLoadingItem(child: PreviewTextPrototype(width: constraints.maxWidth * 0.74, height: 24)),
                      const Spacer(),
                      ShimmerLoadingItem(child: PreviewTextPrototype(width: constraints.maxWidth * 0.62, height: 18)),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: ParkingsConfig.padding,
              child: Align(
                alignment: Alignment.bottomRight,
                child: ShimmerLoadingItem(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: ShimmerLoadingConfig.placeholderColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const SizedBox(width: 96, height: 31),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

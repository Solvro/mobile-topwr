import 'package:flutter/material.dart';

import '../../../config/ui_config.dart';
import '../shimmer_loading.dart';
import '../simple_previews/preview_card_loading.dart';
import '../simple_previews/preview_text_prototype.dart';

class WideTileLoading extends StatelessWidget {
  const WideTileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: shimmerGradient,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(WideTileCardConfig.radius),
        ),
        clipBehavior: Clip.antiAlias,
        child: const Row(
          children: [
            Expanded(child: ShimmerLoadingItem(child: _TitlesColumnLoading())),
            PreviewCardLoading.square(size: WideTileCardConfig.imageSize),
          ],
        ),
      ),
    );
  }
}

class _TitlesColumnLoading extends StatelessWidget {
  const _TitlesColumnLoading();

  static const _firstTextLoadingWidthFraction = 0.8;
  static const _secondTextLoadingWidthFraction = 0.4;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PreviewTextPrototype(
            width: constraints.maxWidth * _firstTextLoadingWidthFraction,
          ),
          const SizedBox(height: WideTileCardConfig.titlesSpacing),
          PreviewTextPrototype(
            width: constraints.maxWidth * _secondTextLoadingWidthFraction,
          ),
          const SizedBox(height: WideTileCardConfig.titlesSpacing),
        ],
      );
    });
  }
}

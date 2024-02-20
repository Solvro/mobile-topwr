import 'package:flutter/material.dart';

import '../../config.dart';
import '../wide_tile_card.dart';
import 'preview_square_card_loading.dart';
import 'preview_text_prototype.dart';
import 'shimmer_loading.dart';

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
            PreviewSquareCardLoading(size: WideTileCardConfig.imageSize),
          ],
        ),
      ),
    );
  }
}

class _TitlesColumnLoading extends StatelessWidget
    with WideTileCardCalcExtraPaddingLeft {
  const _TitlesColumnLoading();

  static const _firstTextLoadingWidthFraction = 0.8;
  static const _secondTextLoadingWidthFraction = 0.4;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.only(
          left: calcExtraLeftPadding(constraints) +
              WideTileCardConfig.basePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PreviewTextPrototype(
              width: constraints.maxWidth * _firstTextLoadingWidthFraction,
            ),
            const SizedBox(height: 8),
            PreviewTextPrototype(
              width: constraints.maxWidth * _secondTextLoadingWidthFraction,
            ),
          ],
        ),
      );
    });
  }
}

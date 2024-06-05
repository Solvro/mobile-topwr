import 'package:flutter/material.dart';

import '../../../config/ui_config.dart';
import '../simple_previews/preview_text_prototype.dart';
import '../shimmer_loading.dart';

class BigPreviewCardLoading extends StatelessWidget {
  const BigPreviewCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        linearGradient: shimmerGradient,
        child: Column(
          children: [
            ShimmerLoadingItem(
              child: Container(
                width: BigPreviewCardConfig.cardWidth,
                height: 135,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const ShimmerLoadingItem(child: _LoadingText())
          ],
        ));
  }
}

class _LoadingText extends StatelessWidget {
  const _LoadingText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        PreviewTextPrototype(width: BigPreviewCardConfig.cardWidth),
        const SizedBox(height: 16),
        PreviewTextPrototype(width: BigPreviewCardConfig.cardWidth / 1.5)
      ],
    );
  }
}

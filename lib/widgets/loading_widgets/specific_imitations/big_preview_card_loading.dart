import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../shimmer_loading.dart";
import "../simple_previews/preview_text_prototype.dart";

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
              height: 155,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const ShimmerLoadingItem(child: _LoadingText()),
        ],
      ),
    );
  }
}

class _LoadingText extends StatelessWidget {
  const _LoadingText();

  @override
  Widget build(BuildContext context) {
    const gap = 22.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: gap),
        PreviewTextPrototype(width: BigPreviewCardConfig.cardWidth, height: 25),
        const SizedBox(height: gap),
        PreviewTextPrototype(width: BigPreviewCardConfig.cardWidth / 1.3, height: 25),
        const SizedBox(height: gap),
        PreviewTextPrototype(width: BigPreviewCardConfig.cardWidth / 2.5, height: 25),
      ],
    );
  }
}

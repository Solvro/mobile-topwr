import 'package:flutter/material.dart';
import 'shimmer_loading.dart';
import '../../config.dart';

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
  const _LoadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 16),
      Container(
        width: BigPreviewCardConfig.cardWidth,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      const SizedBox(height: 16),
      Container(
        width: BigPreviewCardConfig.cardWidth / 1.5,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ]);
  }
}

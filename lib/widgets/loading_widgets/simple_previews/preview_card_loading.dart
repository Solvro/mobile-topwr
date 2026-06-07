import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../shimmer_loading.dart";

class PreviewCardLoading extends StatelessWidget {
  const PreviewCardLoading({
    super.key,
    required this.width,
    required this.height,
    this.color = ShimmerLoadingConfig.placeholderColor,
  });

  const PreviewCardLoading.square({super.key, required double size, this.color = ShimmerLoadingConfig.placeholderColor})
    : width = size,
      height = size;
  final double width;
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ShimmeringEffect(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

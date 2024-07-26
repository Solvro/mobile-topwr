import "package:flutter/material.dart";

import "../shimmer_loading.dart";

class PreviewCardLoading extends StatelessWidget {
  const PreviewCardLoading({
    super.key,
    required this.width,
    required this.height,
    this.color = Colors.white,
  });

  const PreviewCardLoading.square({
    super.key,
    required double size,
    this.color = Colors.white,
  })  : width = size,
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
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

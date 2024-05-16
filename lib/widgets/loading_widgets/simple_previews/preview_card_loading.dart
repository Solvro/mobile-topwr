import 'package:flutter/material.dart';

import '../shimmer_loading.dart';

class PreviewCardLoading extends StatelessWidget {
  const PreviewCardLoading({
    super.key,
    required this.width,
    required this.height,
  });

  const PreviewCardLoading.square({
    super.key,
    required double size,
  })  : width = size,
        height = size;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ShimmeringEffect(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

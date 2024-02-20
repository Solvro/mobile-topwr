import 'package:flutter/material.dart';

import 'shimmer_loading.dart';

class PreviewSquareCardLoading extends StatelessWidget {
  const PreviewSquareCardLoading({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ShimmeringEffect(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

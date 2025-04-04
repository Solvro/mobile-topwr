import "package:flutter/material.dart";

import "../shimmer_loading.dart";

class HorizontalRectangularSectionLoading extends StatelessWidget {
  const HorizontalRectangularSectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmeringEffect(
      child: Container(
        width: double.maxFinite,
        height: 69,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

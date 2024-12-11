import "package:flutter/material.dart";

import "../optimized_directus_image.dart";
import "../zoomable_optimized_directus_image.dart";

class SliverLogo extends StatelessWidget {
  const SliverLogo({
    super.key,
    required this.logoSize,
    required this.logoOpacity,
    required this.scaleFactor,
    required this.activeGradient,
    required this.logoDirectusUrl,
    this.boxfit = BoxFit.contain,
    this.noShimmeringLoading = false,
  });

  final double logoSize;
  final double logoOpacity;
  final double scaleFactor;
  final LinearGradient? activeGradient;
  final String? logoDirectusUrl;
  final BoxFit boxfit;
  final bool noShimmeringLoading;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox.square(
        child: SingleChildScrollView(
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          child: Opacity(
            opacity: logoOpacity,
            child: Card(
              elevation: 3,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  gradient: activeGradient,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox.square(
                    dimension: logoSize * scaleFactor,
                    child:  ZoomableOptimizedDirectusImage(
                      logoDirectusUrl,
                      boxFit: boxfit,
                      noShimmeringLoading: noShimmeringLoading,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


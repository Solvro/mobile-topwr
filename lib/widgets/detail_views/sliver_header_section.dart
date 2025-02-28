import "dart:math";

import "package:flutter/material.dart";

import "../../config/ui_config.dart";
import "../zoomable_images.dart";
import "sliver_logo.dart";

class SliverHeaderSection extends SliverPersistentHeaderDelegate {
  SliverHeaderSection({this.activeGradient, required this.logoDirectusImageUrl, required this.backgroundImageUrl});

  final String? logoDirectusImageUrl;
  final String? backgroundImageUrl;
  final LinearGradient? activeGradient;
  static const maxTopBarHeight = 250;

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 0;

  double calcLogoSize(double shrinkOffset) {
    final ratio = min(1, shrinkOffset / DetailViewsHeaderConfig.logoSize);
    final adjustedRatio = 1.0 - (ratio * 0.3);
    return max(0, DetailViewsHeaderConfig.logoSize * adjustedRatio);
  }

  double calcLogoOpacity(double shrinkOffset, double logoSize) {
    final spaceLeft = maxExtent - shrinkOffset;
    final adjustedRatio = -(spaceLeft - logoSize) / logoSize;
    return 1.0 - max(0, adjustedRatio);
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    final logoSize = calcLogoSize(shrinkOffset);
    final logoOpacity = calcLogoOpacity(shrinkOffset, logoSize);
    final scaleFactor = activeGradient != null ? 0.5 : 1.0;
    return Stack(
      children: [
        Opacity(
          opacity: 1 - progress,
          child: SizedBox(
            height: maxTopBarHeight * (1 - progress),
            width: double.infinity,
            child: ZoomableOptimizedDirectusImage(backgroundImageUrl),
          ),
        ),
        SliverLogo(
          scaleFactor: scaleFactor,
          activeGradient: activeGradient,
          logoDirectusUrl: logoDirectusImageUrl,
          logoOpacity: logoOpacity,
          logoSize: logoSize,
          boxfit: BoxFit.scaleDown,
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

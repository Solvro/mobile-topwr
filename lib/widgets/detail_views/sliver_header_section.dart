import "dart:math";

import "package:flutter/material.dart";

import "../../api_base_rest/shared_models/image_data.dart";
import "../../config/ui_config.dart";
import "../../utils/context_extensions.dart";
import "../zoomable_images.dart";
import "sliver_logo.dart";

class SliverHeaderSection extends SliverPersistentHeaderDelegate {
  SliverHeaderSection({this.activeGradient, this.logoDirectusImageData, this.backgroundImageData});

  final ImageData? logoDirectusImageData;
  final ImageData? backgroundImageData;
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
        ExcludeSemantics(
          child: Opacity(
            opacity: 1 - progress,
            child: SizedBox(
              height: maxTopBarHeight * (1 - progress),
              width: double.infinity,
              child: backgroundImageData != null
                  ? ZoomableRestApiImage(backgroundImageData, useFullImageQuality: true)
                  : const ZoomableRestApiImage(null),
            ),
          ),
        ),
        Semantics(
          label: context.localize.logotype,
          image: true,
          button: false,
          child: ExcludeSemantics(
            child: SliverLogo(
              scaleFactor: scaleFactor,
              activeGradient: activeGradient,
              logoDirectusUrl: logoDirectusImageData?.effectiveUrl,
              logoOpacity: logoOpacity,
              logoSize: logoSize,
              boxfit: BoxFit.scaleDown,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

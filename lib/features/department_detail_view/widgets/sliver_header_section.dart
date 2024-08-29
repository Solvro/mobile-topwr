import "package:flutter/material.dart";

import "../../../widgets/detail_views/sliver_header_section.dart";
import "../../../widgets/detail_views/sliver_logo.dart";

class DepartmentSliverHeaderSection extends SliverHeaderSection {
  DepartmentSliverHeaderSection({
    super.activeGradient,
    super.logoDirectusImageUrl,
  }) : super(backgroundImageUrl: null);

  @override
  double get maxExtent => 140;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final logoSize = calcLogoSize(shrinkOffset);
    final logoOpacity = calcLogoOpacity(shrinkOffset, logoSize);
    final scaleFactor = activeGradient != null ? 0.5 : 1.0;
    return Stack(
      children: [
        SliverLogo(
          scaleFactor: scaleFactor,
          activeGradient: activeGradient,
          logoDirectusUrl: logoDirectusImageUrl,
          logoOpacity: logoOpacity,
          logoSize: logoSize,
          boxfit: BoxFit.scaleDown,
          noShimmeringLoading: true,
        ),
      ],
    );
  }
}

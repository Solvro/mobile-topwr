import "package:flutter/material.dart";

import "../../../widgets/detail_views/sliver_header_section.dart";
import "../../../widgets/detail_views/sliver_logo.dart";

class DepartmentSliverHeaderSection extends SliverHeaderSection {
  DepartmentSliverHeaderSection({
    super.activeGradient,
    super.logoImageUrl,
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
          logoImageUrl: logoImageUrl,
          logoOpacity: logoOpacity,
          logoSize: logoSize,
        ),
      ],
    );
  }
}

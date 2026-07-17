import "package:flutter/material.dart";

import "../../api_base_rest/shared_models/image_data.dart";
import "../my_cached_image.dart";
import "sliver_header_section.dart";
import "sliver_logo.dart";

class LogoOnlySliverHeaderSection extends SliverHeaderSection {
  LogoOnlySliverHeaderSection({super.activeGradient, ImageData? logoImageData})
    : super(logoDirectusImageData: logoImageData, backgroundImageData: null);

  @override
  double get maxExtent => 140;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final logoSize = calcLogoSize(shrinkOffset);
    final logoOpacity = calcLogoOpacity(shrinkOffset, logoSize);
    final scaleFactor = activeGradient != null ? 0.5 : 1.0;
    return SliverLogo(
      scaleFactor: scaleFactor,
      activeGradient: activeGradient,
      logoDirectusUrl: logoDirectusImageData?.effectiveUrl,
      logoOpacity: logoOpacity,
      logoSize: logoSize,
      boxfit: BoxFit.scaleDown,
      loadingType: LoadingType.noLoading,
    );
  }
}

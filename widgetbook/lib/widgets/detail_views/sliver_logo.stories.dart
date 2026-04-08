import "package:flutter/material.dart";
import "package:topwr/widgets/detail_views/sliver_logo.dart";
import "package:topwr/widgets/my_cached_image.dart";
import "package:widgetbook/widgetbook.dart";

part "sliver_logo.stories.g.dart";

class SliverLogoStoryKnobs {
  final double logoSize;
  final double logoOpacity;
  final double scaleFactor;
  final LinearGradient? activeGradient;
  final String logoDirectusUrl;
  final BoxFit boxfit;
  final LoadingType loadingType;
  SliverLogoStoryKnobs({
    required this.logoSize,
    required this.logoOpacity,
    required this.scaleFactor,
    this.activeGradient,
    required this.logoDirectusUrl,
    required this.boxfit,
    required this.loadingType,
  });
}

const meta = MetaWithArgs<SliverLogo, SliverLogoStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => SliverLogo(
    logoSize: args.logoSize,
    logoOpacity: args.logoOpacity,
    scaleFactor: args.scaleFactor,
    activeGradient: args.activeGradient,
    logoDirectusUrl: args.logoDirectusUrl,
    boxfit: args.boxfit,
    loadingType: args.loadingType,
  ),
);

final $default = SliverLogoStory();

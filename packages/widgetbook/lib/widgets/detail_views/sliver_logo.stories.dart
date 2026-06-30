import "package:flutter/material.dart";
import "package:topwr/widgets/detail_views/sliver_logo.dart";
import "package:topwr/widgets/my_cached_image.dart";
import "package:widgetbook/widgetbook.dart";
import "../../widgetbook_placeholders.dart";

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

const meta = Meta(SliverLogo.new, argsType: SliverLogoStoryKnobs.new);

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

/// Same host as other widgetbook image mocks; avoids empty defaults (0 size,
/// 0 opacity, no URL) from [SliverLogoStoryKnobsArgs] which render nothing.
const _previewLogoUrl = widgetbookPlaceholderImageUrl;

const _previewRingGradient = LinearGradient(
  colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final $default = SliverLogoStory(
  args: SliverLogoStoryKnobsArgs(
    logoSize: DoubleArg(100),
    logoOpacity: DoubleArg(1),
    scaleFactor: DoubleArg(1),
    activeGradient: Arg.fixed(_previewRingGradient),
    logoDirectusUrl: Arg.fixed(_previewLogoUrl),
    boxfit: Arg.fixed(BoxFit.contain),
    loadingType: Arg.fixed(LoadingType.shimmerLoading),
  ),
);

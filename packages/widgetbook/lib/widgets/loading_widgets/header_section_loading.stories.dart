import "package:flutter/widgets.dart";
import "package:topwr/widgets/loading_widgets/header_section_loading.dart";
import "package:topwr/widgets/loading_widgets/shimmer_loading.dart";
import "package:widgetbook/widgetbook.dart";

part "header_section_loading.stories.g.dart";

const meta = Meta<HeaderSectionLoading>();

final defaults = _Defaults(
  setup: (context, child, args) => Shimmer(linearGradient: shimmerGradient, child: child),
  builder: (context, args) => const HeaderSectionLoading(),
);

final $default = HeaderSectionLoadingStory();

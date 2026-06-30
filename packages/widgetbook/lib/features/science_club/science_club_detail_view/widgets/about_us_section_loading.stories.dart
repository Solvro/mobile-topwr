import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_club_detail_view/widgets/about_us_section_loading.dart";
import "package:topwr/widgets/loading_widgets/shimmer_loading.dart";
import "package:widgetbook/widgetbook.dart";

part "about_us_section_loading.stories.g.dart";

const meta = Meta(AboutUsSectionLoading.new);

final $default = AboutUsSectionLoadingStory(
  setup: (context, child, args) => SizedBox(
    width: 380,
    child: Shimmer(linearGradient: shimmerGradient, child: child),
  ),
);

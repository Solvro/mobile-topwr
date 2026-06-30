import "package:flutter/material.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_view_loading.dart";
import "package:topwr/widgets/loading_widgets/shimmer_loading.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_menu_tiles_loading.stories.g.dart";

const meta = Meta(SksMenuTilesLoading.new);

final $default = SksMenuTilesLoadingStory(
  setup: (context, child, args) => SizedBox(
    width: 390,
    height: 720,
    child: Shimmer(linearGradient: shimmerGradient, child: child),
  ),
);

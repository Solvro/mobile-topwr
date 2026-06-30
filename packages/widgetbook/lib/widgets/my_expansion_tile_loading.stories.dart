import "package:flutter/material.dart";
import "package:topwr/widgets/loading_widgets/shimmer_loading.dart";
import "package:topwr/widgets/my_expansion_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "my_expansion_tile_loading.stories.g.dart";

const meta = Meta(MyExpansionTileLoading.new);

final $default = MyExpansionTileLoadingStory(
  setup: (context, child, args) => SizedBox(
    width: 360,
    child: Shimmer(linearGradient: shimmerGradient, child: child),
  ),
);

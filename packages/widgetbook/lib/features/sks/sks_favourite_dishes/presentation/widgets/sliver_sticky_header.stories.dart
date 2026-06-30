import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_favourite_dishes/presentation/widgets/sliver_sticky_header.dart";
import "package:widgetbook/widgetbook.dart";

part "sliver_sticky_header.stories.g.dart";

const meta = Meta(SliverStickyHeader.new);

final $default = SliverStickyHeaderStory(
  args: SliverStickyHeaderArgs.fixed(child: const Text("Lorem ipsum")),
  setup: (context, child, args) {
    return CustomScrollView(slivers: [child]);
  },
);

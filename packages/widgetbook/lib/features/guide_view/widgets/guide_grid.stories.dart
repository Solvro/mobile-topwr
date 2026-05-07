import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/guide_view/widgets/guide_grid.dart";
import "package:widgetbook/widgetbook.dart";

part "guide_grid.stories.g.dart";

final _mockGuideGridChildren = IList<Widget>(const [SizedBox(width: 48, height: 48), SizedBox(width: 48, height: 48)]);

const meta = Meta<GuideGrid>();

final $default = GuideGridStory(args: GuideGridArgs(children: Arg.fixed(_mockGuideGridChildren)));

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/guide_view/widgets/guide_grid.dart";
import "package:widgetbook/widgetbook.dart";

part "guide_grid.stories.g.dart";

final _mockGuideGridChildren = IList<Widget>(const [
  Card(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Center(child: Text("Student essentials")),
    ),
  ),
  Card(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Center(child: Text("Campus services")),
    ),
  ),
  Card(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Center(child: Text("Before classes")),
    ),
  ),
]);

const meta = Meta(GuideGrid.new);

final $default = GuideGridStory(args: GuideGridArgs(children: Arg.fixed(_mockGuideGridChildren)));

import "package:flutter/material.dart";
import "package:topwr/widgets/my_expansion_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "my_expansion_tile.stories.g.dart";

class MyExpansionTileStoryKnobs {
  final String title;
  final bool initiallyExpanded;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final List<Widget> children;
  MyExpansionTileStoryKnobs({
    required this.title,
    required this.initiallyExpanded,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    required this.children,
  });
}

const meta = MetaWithArgs<MyExpansionTile, MyExpansionTileStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => MyExpansionTile(
    title: args.title,
    initiallyExpanded: args.initiallyExpanded,
    backgroundColor: args.backgroundColor,
    collapsedBackgroundColor: args.collapsedBackgroundColor,
    children: args.children,
  ),
);

final $default = MyExpansionTileStory(
  args: MyExpansionTileStoryKnobsArgs(children: Arg.fixed(const [Text("First child"), Text("Second child")])),
);

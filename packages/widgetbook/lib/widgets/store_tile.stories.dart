import "package:flutter/material.dart";
import "package:topwr/widgets/store_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "store_tile.stories.g.dart";

class StoreTileStoryKnobs {
  final IconData icon;
  final String label;
  final String storeName;
  final String url;
  StoreTileStoryKnobs({required this.icon, required this.label, required this.storeName, required this.url});
}

const meta = MetaWithArgs<StoreTile, StoreTileStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => StoreTile(icon: args.icon, label: args.label, storeName: args.storeName, url: args.url),
);

final $default = StoreTileStory(
  args: StoreTileStoryKnobsArgs(
    icon: Arg.fixed(Icons.android),
    label: StringArg("Android"),
    storeName: StringArg("Google Play"),
    url: StringArg("https://play.google.com/store"),
  ),
);

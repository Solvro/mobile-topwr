import "package:flutter/material.dart";
import "package:topwr/features/navigation_tab_view/widgets/navigation_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "navigation_tile.stories.g.dart";

const meta = Meta<NavigationTile>();

final $default = NavigationTileStory(
  args: NavigationTileArgs(title: StringArg("Map"), icon: Arg.fixed(Icons.map_outlined)),
);

import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_splash_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "my_splash_tile.stories.g.dart";

const meta = Meta(MySplashTile.new);

final $default = MySplashTileStory(
  args: MySplashTileArgs(
    child: Arg.fixed(const Padding(padding: EdgeInsets.all(24), child: Text("Tap tile content"))),
    onTap: Arg.fixed(() {}),
  ),
);

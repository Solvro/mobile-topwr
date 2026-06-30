import "package:flutter/material.dart";
import "package:topwr/widgets/tile_splash.dart";
import "package:widgetbook/widgetbook.dart";

part "tile_splash.stories.g.dart";

const meta = Meta(TileSplash.new);

final $default = TileSplashStory(
  args: TileSplashArgs(onTap: Arg.fixed(() {})),
  builder: (context, args) => TileSplash(
    onTap: args.onTap,
    child: SizedBox(
      width: 240,
      height: 120,
      child: Card(
        child: Center(child: Text("Tap to preview splash", style: Theme.of(context).textTheme.titleMedium)),
      ),
    ),
  ),
);

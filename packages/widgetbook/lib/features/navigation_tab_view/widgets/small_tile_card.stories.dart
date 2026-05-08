import "package:flutter/material.dart";
import "package:topwr/features/navigation_tab_view/widgets/small_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "small_tile_card.stories.g.dart";

const meta = Meta<SmallTileCard>();

final $default = SmallTileCardStory(
  args: SmallTileCardArgs.fixed(title: "Campus map", icon: const Icon(Icons.map_outlined, size: 36), onTap: () {}),
);

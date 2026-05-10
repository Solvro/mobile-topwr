import "package:flutter/material.dart";
import "package:topwr/features/navigation_tab_view/widgets/small_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "base_small_tile_card.stories.g.dart";

const meta = Meta<BaseSmallTileCard>();

final $default = BaseSmallTileCardStory(
  args: BaseSmallTileCardArgs.fixed(
    child: const Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(Icons.touch_app), SizedBox(width: 12), Text("Base small tile")],
      ),
    ),
  ),
);

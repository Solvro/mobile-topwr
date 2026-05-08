import "package:flutter/material.dart";
import "package:topwr/features/radio_luz/presentation/radio_player_info.dart";
import "package:widgetbook/widgetbook.dart";

part "radio_player_info.stories.g.dart";

const meta = Meta<RadioPlayerInfo>();

final $default = RadioPlayerInfoStory(
  setup: (context, child, args) => ColoredBox(
    color: const Color(0xFF1C1B2F),
    child: Row(children: [child]),
  ),
);

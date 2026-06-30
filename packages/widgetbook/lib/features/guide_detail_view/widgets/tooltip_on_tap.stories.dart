import "package:flutter/material.dart";
import "package:topwr/features/guide_detail_view/widgets/tooltip_on_click.dart";
import "package:widgetbook/widgetbook.dart";

part "tooltip_on_tap.stories.g.dart";

const meta = Meta(TooltipOnTap.new);

final $default = TooltipOnTapStory(
  args: TooltipOnTapArgs.fixed(
    message: "Updated May 2026",
    child: const Padding(padding: EdgeInsets.all(24), child: Text("Tap to show tooltip")),
  ),
);

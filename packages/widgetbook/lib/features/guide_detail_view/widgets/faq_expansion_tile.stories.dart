import "package:flutter/widgets.dart";
import "package:topwr/features/guide_detail_view/widgets/faq_expansion_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "faq_expansion_tile.stories.g.dart";

const meta = Meta(FaqExpansionTile.new);

final $default = FaqExpansionTileStory(
  args: FaqExpansionTileArgs(
    title: StringArg("Where can I find registration dates?"),
    description: StringArg("Check USOS announcements and faculty communication channels."),
    initiallyExpanded: BoolArg(true),
  ),
);

import "package:flutter/widgets.dart";
import "package:topwr/features/guide_detail_view/widgets/tooltip_on_click.dart";
import "package:widgetbook/widgetbook.dart";

part "custom_date_tooltip.stories.g.dart";

const meta = Meta<CustomDateTooltip>();

final $default = CustomDateTooltipStory(
  args: CustomDateTooltipArgs.fixed(position: const Offset(180, 24), message: "Updated May 2026"),
  setup: (context, child, args) => Stack(children: [child]),
);

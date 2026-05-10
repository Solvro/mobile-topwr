import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_tooltip.dart";
import "package:widgetbook/widgetbook.dart";

part "my_tooltip.stories.g.dart";

const meta = Meta<MyTooltip>();

final $default = MyTooltipStory(
  args: MyTooltipArgs(
    message: StringArg("Helpful tooltip text"),
    child: Arg.fixed(const Text("Hover or long press me")),
  ),
);

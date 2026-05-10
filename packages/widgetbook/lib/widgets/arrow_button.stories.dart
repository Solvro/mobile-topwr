import "package:flutter/material.dart";
import "package:topwr/widgets/arrow_button.dart";
import "package:widgetbook/widgetbook.dart";

part "arrow_button.stories.g.dart";

const meta = Meta<ArrowButton>();

final $default = ArrowButtonStory(
  args: ArrowButtonArgs(icon: Arg.fixed(Icons.arrow_back), onPressed: Arg.fixed(() {})),
);

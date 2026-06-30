import "package:flutter/material.dart";
import "package:topwr/features/science_club/science_clubs_filters/widgets/filter_chip.dart";
import "package:widgetbook/widgetbook.dart";

part "my_filter_chip.stories.g.dart";

class MyFilterChipStoryKnobs {
  final String label;
  final bool selected;
  final Color? selectedColor;
  final Color? selectedBorderColor;
  final String? tooltip;
  MyFilterChipStoryKnobs({
    required this.label,
    required this.selected,
    this.selectedColor,
    this.selectedBorderColor,
    this.tooltip,
  });
}

const meta = Meta(MyFilterChip.new, argsType: MyFilterChipStoryKnobs.new);

final defaults = _Defaults(
  builder: (context, args) => MyFilterChip(
    label: args.label,
    selected: args.selected,
    onTap: () {},
    selectedColor: args.selectedColor,
    selectedBorderColor: args.selectedBorderColor,
    tooltip: args.tooltip,
  ),
);

final $default = MyFilterChipStory(
  args: MyFilterChipStoryKnobsArgs(label: StringArg("Informatyka"), selected: BoolArg(false)),
);

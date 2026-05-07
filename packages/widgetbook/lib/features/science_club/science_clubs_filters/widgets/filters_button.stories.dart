import "package:flutter/material.dart";
import "package:topwr/features/science_club/science_clubs_filters/widgets/filters_button.dart";
import "package:widgetbook/widgetbook.dart";

part "filters_button.stories.g.dart";

class FiltersButtonStoryKnobs {
  final String text;
  final IconData icon;
  final bool isSecondary;
  FiltersButtonStoryKnobs({required this.text, required this.icon, required this.isSecondary});
}

const meta = MetaWithArgs<FiltersButton, FiltersButtonStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) =>
      FiltersButton(text: args.text, icon: args.icon, onPressed: () {}, isSecondary: args.isSecondary),
);

final $default = FiltersButtonStory(args: FiltersButtonStoryKnobsArgs(icon: Arg.fixed(Icons.filter_alt)));

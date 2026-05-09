import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";
import "package:widgetbook/widgetbook.dart";

part "red_dialog.stories.g.dart";

class RedDialogStoryKnobs {
  final String title;
  final String? subtitle;
  final bool showApplyButton;
  final bool centerTitle;
  final String? applyButtonText;
  final bool showCloseButton;
  RedDialogStoryKnobs({
    required this.title,
    this.subtitle,
    required this.showApplyButton,
    required this.centerTitle,
    this.applyButtonText,
    required this.showCloseButton,
  });
}

const meta = MetaWithArgs<RedDialog, RedDialogStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => RedDialog(
    title: args.title,
    subtitle: args.subtitle,
    showApplyButton: args.showApplyButton,
    centerTitle: args.centerTitle,
    applyButtonText: args.applyButtonText,
    showCloseButton: args.showCloseButton,
    onApplyButtonPressed: () {},
    child: const SizedBox(width: 100, height: 100),
  ),
);

final $default = RedDialogStory(
  args: RedDialogStoryKnobsArgs(
    title: StringArg("Accessibility options"),
    subtitle: NullableStringArg("Choose preferences for easier navigation."),
    showApplyButton: BoolArg(true),
    centerTitle: BoolArg(false),
    applyButtonText: NullableStringArg("Apply"),
    showCloseButton: BoolArg(true),
  ),
);

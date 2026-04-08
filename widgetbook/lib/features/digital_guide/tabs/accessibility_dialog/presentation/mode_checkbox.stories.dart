import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/data/modes.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/presentation/mode_checkbox.dart";
import "package:widgetbook/widgetbook.dart";

part "mode_checkbox.stories.g.dart";

const meta = Meta<ModeCheckbox>();

final $default = ModeCheckboxStory(args: ModeCheckboxArgs(mode: Arg.fixed(const Blind())));

import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/radio_player_control_button.dart";
import "package:topwr/features/radio_luz/service/radio_player_controller.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../radio_luz_mocks.dart";

part "radio_player_control_button.stories.g.dart";

const meta = Meta<RadioPlayerControlButton>();

final $default = RadioPlayerControlButtonStory(
  args: RadioPlayerControlButtonArgs(radioController: Arg.fixed(mockRadioController)),
);

import "package:flutter/material.dart";
import "package:topwr/features/radio_luz/presentation/radio_player_control_button.dart";
import "package:topwr/features/radio_luz/service/radio_player_controller.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../radio_luz_mocks.dart";

part "radio_player_control_button.stories.g.dart";

const meta = Meta<RadioPlayerControlButton>();

final $stopped = RadioPlayerControlButtonStory(
  name: "Stopped",
  args: RadioPlayerControlButtonArgs.fixed(radioController: mockRadioController),
  setup: _darkBackground,
);

final $playing = RadioPlayerControlButtonStory(
  name: "Playing",
  args: RadioPlayerControlButtonArgs.fixed(radioController: mockRadioController, isPlaying: true),
  setup: _darkBackground,
);

final $loading = RadioPlayerControlButtonStory(
  name: "Loading",
  args: RadioPlayerControlButtonArgs.fixed(radioController: mockRadioController, isLoading: true),
  setup: _darkBackground,
);

Widget _darkBackground(BuildContext context, Widget child, RadioPlayerControlButtonArgs args) {
  return ColoredBox(
    color: const Color(0xFF1C1B2F),
    child: Center(child: child),
  );
}

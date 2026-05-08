import "package:flutter/material.dart";
import "package:topwr/features/radio_luz/presentation/radio_player_slider.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../radio_luz_mocks.dart";

part "radio_player_slider.stories.g.dart";

class RadioPlayerSliderStory extends StatelessWidget {
  const RadioPlayerSliderStory({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF1C1B2F),
      child: Center(
        child: RadioPlayerSlider(radioController: mockRadioController, volume: mockRadioController.state.volume),
      ),
    );
  }
}

const meta = Meta<RadioPlayerSliderStory>();

final $default = RadioPlayerSliderStoryStory();

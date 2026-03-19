import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/radio_player_slider.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

import "radio_player_control_button.dart";

@widgetbook.UseCase(name: "default", type: RadioPlayerSlider)
Widget useCaseRadioPlayerSlider(BuildContext context) {
  return RadioPlayerSlider(radioController: FakeRadioController(), volume: 0.5);
}

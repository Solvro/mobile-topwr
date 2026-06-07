import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../service/radio_player_controller.dart";
import "rect_thum_shape.dart";

class RadioPlayerSlider extends StatelessWidget {
  const RadioPlayerSlider({super.key, required this.radioController, required this.volume});

  final RadioController radioController;
  final double volume;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.25,
      child: SliderTheme(
        data: SliderThemeData(
          thumbShape: const RectThumbShape(width: 4, height: 14),
          thumbColor: context.colorScheme.onPrimary,
          trackHeight: 3,
          trackShape: const RectangularSliderTrackShape(),
          activeTrackColor: context.colorScheme.onPrimary,
          inactiveTrackColor: context.colorScheme.onPrimary,
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
        ),
        child: Slider(
          value: volume,
          onChangeEnd: radioController.rememberVolume,
          onChanged: (newVolume) async {
            await radioController.setVolume(newVolume);
          },
        ),
      ),
    );
  }
}

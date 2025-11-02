import "package:flutter/material.dart";

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
        data: const SliderThemeData(
          thumbShape: RectThumbShape(width: 4, height: 14),
          thumbColor: Colors.white,
          trackHeight: 3,
          trackShape: RectangularSliderTrackShape(),
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.white,
          overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
        ),
        child: Slider(
          value: volume,
          onChanged: (newVolume) async {
            await radioController.setVolume(newVolume);
          },
        ),
      ),
    );
  }
}

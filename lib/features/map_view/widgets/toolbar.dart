import "package:flutter/material.dart";
import "package:flutter_map_compass/flutter_map_compass.dart";

import "../../my_location_button/presentation/my_loc_button.dart";

class Toolbar extends StatelessWidget {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 16,
      right: 8,
      child: SafeArea(
        child: Column(
          children: [
            MyLocationButton(),
            SizedBox(height: 4),
            MapCompass.cupertino(hideIfRotatedNorth: true, padding: EdgeInsets.zero),
          ],
        ),
      ),
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_map_compass/flutter_map_compass.dart";

import "../../../utils/context_extensions.dart";
import "../../branches/presentation/branches_map_button.dart";
import "../../map_layer_picker/presentation/layers_toolbar_button.dart";
import "../../my_loc_button/presentation/my_loc_button.dart";

class Toolbar extends StatelessWidget {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: context.textScaler.clamp(maxScaleFactor: 1.5).scale(8),
      child: const SafeArea(
        child: Column(
          spacing: 4,
          children: [
            MyLocationButton(),
            LayersButton(),
            BranchesButton(),
            MapCompass.cupertino(hideIfRotatedNorth: true, padding: EdgeInsets.zero),
          ],
        ),
      ),
    );
  }
}

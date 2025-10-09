import "package:flutter/material.dart";
import "package:flutter_map_compass/flutter_map_compass.dart";

import "../../../utils/context_extensions.dart";
import "../../branches/presentation/branches_map_button.dart";
import "../../map_layer_picker/presentation/layers_toolbar_button.dart";
import "../../multilayer_map/data/model/multilayer_item.dart";
import "../../my_loc_button/presentation/my_loc_button.dart";
import "../controllers/controllers_set.dart";

class Toolbar<T extends GoogleNavigable> extends StatelessWidget {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: context.textScaler.clamp(maxScaleFactor: 1.5).scale(8),
      child: SafeArea(
        child: Column(
          spacing: 4,
          children: [
            const MyLocationButton(),
            if (T == MultilayerItem) const LayersButton(),
            if (T == MultilayerItem) const BranchesButton(),
            const MapCompass.cupertino(hideIfRotatedNorth: true, padding: EdgeInsets.zero),
          ],
        ),
      ),
    );
  }
}

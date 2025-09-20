import "package:flutter/material.dart";

import "../../../utils/context_extensions.dart";
import "../data/layer_options.dart";

extension LayerOptionsLocalizationX on LayerOptions {
  String localizedLabel(BuildContext context) {
    return switch (this) {
      BuildingLayerOptions() => context.localize.building_prefix,
      LibraryLayerOptions() => context.localize.library_title,
      AedLayerOptions() => context.localize.aed_title,
      BicycleShowerLayerOptions() => context.localize.showers_title_long,
      PinkBoxLayerOptions() => context.localize.pink_boxes_title,
    };
  }
}

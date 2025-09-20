import "package:flutter/material.dart";

import "../../../gen/assets.gen.dart";
import "../../../theme/hex_color.dart";
import "../data/layer_options.dart";

class LayerMarkerIcon extends StatelessWidget {
  const LayerMarkerIcon({super.key, required this.option, required this.isEnabled});

  final LayerOptions option;
  final bool isEnabled;

  Color get markerColor => switch (option) {
    BuildingLayerOptions() => HexColor("#3F6499"),
    LibraryLayerOptions() => HexColor("#815934"),
    AedLayerOptions() => HexColor("#64AD5C"),
    BicycleShowerLayerOptions() => HexColor("#3F6499"),
    PinkBoxLayerOptions() => HexColor("#FF1393"),
  };

  @override
  Widget build(BuildContext context) {
    final markerImage = switch (option) {
      BuildingLayerOptions() => Assets.png.mapMarkers.mapMarker.image(),
      LibraryLayerOptions() => Assets.png.mapMarkers.libraryMarker.image(),
      AedLayerOptions() => Assets.png.mapMarkers.aedMarker.image(),
      BicycleShowerLayerOptions() => Assets.png.mapMarkers.showerMarker.image(),
      PinkBoxLayerOptions() => Assets.png.mapMarkers.pinkBoxMarker.image(),
    };

    return SizedBox(
      height: 25,
      child: isEnabled
          ? DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: markerColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: markerImage,
            )
          : markerImage,
    );
  }
}

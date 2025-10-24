sealed class LayerOptions {
  const LayerOptions(this.sharedPrefsKey);
  final String sharedPrefsKey;
}

class BuildingLayerOptions extends LayerOptions {
  const BuildingLayerOptions() : super("building_layer_options");
}

class LibraryLayerOptions extends LayerOptions {
  const LibraryLayerOptions() : super("library_layer_options");
}

class AedLayerOptions extends LayerOptions {
  const AedLayerOptions() : super("aed_layer_options");
}

class BicycleShowerLayerOptions extends LayerOptions {
  const BicycleShowerLayerOptions() : super("bicycle_shower_layer_options");
}

class PinkBoxLayerOptions extends LayerOptions {
  const PinkBoxLayerOptions() : super("pink_box_layer_options");
}

final topLevelLayerOptions = [
  const BuildingLayerOptions(),
  const LibraryLayerOptions(),
  const AedLayerOptions(),
  const BicycleShowerLayerOptions(),
  const PinkBoxLayerOptions(),
];

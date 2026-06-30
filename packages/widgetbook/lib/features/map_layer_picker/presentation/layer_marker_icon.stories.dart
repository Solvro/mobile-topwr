import "package:flutter/widgets.dart";
import "package:topwr/features/map_layer_picker/data/layer_options.dart";
import "package:topwr/features/map_layer_picker/presentation/layer_marker_icon.dart";
import "package:widgetbook/widgetbook.dart";

part "layer_marker_icon.stories.g.dart";

const _mockLayerOptions = BuildingLayerOptions();

const meta = Meta(LayerMarkerIcon.new);

final $default = LayerMarkerIconStory(args: LayerMarkerIconArgs(option: Arg.fixed(_mockLayerOptions)));

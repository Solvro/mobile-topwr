import "package:flutter/widgets.dart";
import "package:topwr/features/map_layer_picker/data/layer_options.dart";
import "package:topwr/features/map_layer_picker/presentation/map_layer_checkbox.dart";
import "package:widgetbook/widgetbook.dart";

part "map_layer_checkbox.stories.g.dart";

const _mockLayerOptions = BuildingLayerOptions();

const meta = Meta(MapLayerCheckbox.new);

final $default = MapLayerCheckboxStory(args: MapLayerCheckboxArgs(option: Arg.fixed(_mockLayerOptions)));

import "package:flutter/widgets.dart";
import "package:topwr/features/map_view/controllers/controllers_set.dart";
import "package:topwr/features/map_view/widgets/map_widget.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:widgetbook/widgetbook.dart";

part "map_widget.stories.g.dart";

const meta = Meta<MapWidget>();

final $default = MapWidgetStory<MultilayerItem>(args: MapWidgetArgs.fixed(semanticsLabel: "Campus map preview"));

import "package:flutter/widgets.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:topwr/features/map_view/controllers/controllers_set.dart";
import "package:topwr/features/map_view/widgets/markers_layer.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:widgetbook/widgetbook.dart";

part "markers_consumer_layer.stories.g.dart";

const meta = Meta(MarkersConsumerLayer.new);

final $default = MarkersConsumerLayerStory<MultilayerItem>(
  setup: (context, child, args) => FlutterMap(
    options: const MapOptions(initialCenter: LatLng(51.1079, 17.0601), initialZoom: 16),
    children: [child],
  ),
);

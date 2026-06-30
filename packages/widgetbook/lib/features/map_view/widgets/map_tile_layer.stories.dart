import "package:flutter/widgets.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:topwr/features/map_view/widgets/map_widget.dart";
import "package:widgetbook/widgetbook.dart";

part "map_tile_layer.stories.g.dart";

const meta = Meta(MapTileLayer.new);

final $default = MapTileLayerStory(
  setup: (context, child, args) => SizedBox(
    width: 390,
    height: 390,
    child: FlutterMap(
      options: const MapOptions(initialCenter: LatLng(51.1079, 17.0614), initialZoom: 15),
      children: [child],
    ),
  ),
);

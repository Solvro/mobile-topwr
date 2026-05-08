import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:topwr/features/map_view/widgets/map_widget.dart";
import "package:widgetbook/widgetbook.dart";

part "map_tile_layer.stories.g.dart";

const meta = Meta<MapTileLayer>();

final $default = MapTileLayerStory(
  setup: (context, child, args) => FlutterMap(
    options: const MapOptions(initialCenter: LatLng(51.1079, 17.0601), initialZoom: 16),
    children: [child],
  ),
);

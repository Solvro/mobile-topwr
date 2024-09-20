import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/map_view_config.dart";
import "../../../theme/app_theme.dart";
import "../controllers/controllers_set.dart";
import "map_atrribution.dart";
import "map_config.dart";
import "markers_layer.dart";

class MapWidget<T extends GoogleNavigable> extends ConsumerWidget {
  const MapWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: MapWidgetConfig.initialCenter,
        initialZoom: MapWidgetConfig.initialZoom,
        backgroundColor: context.colorTheme.whiteSoap,
        onTap:
            ref.watch(context.mapController<T>().notifier).onMapBackgroundTap,
      ),
      mapController: ref.watch(context.mapController<T>()),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: Platform.isIOS
              ? "com.solvro.ToPwr"
              : "com.solvro.topwr", // not sure why this is needed; but is recommended in the docs
        ),
        MarkersConsumerLayer<T>(),
        const OpenMapAtrribution(),
      ],
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/map_view_config.dart";
import "../../../theme/app_theme.dart";
import "../../my_location_button/presentation/is_following_controller.dart";
import "../../my_location_button/presentation/my_loc_button.dart";
import "../../my_location_button/presentation/my_loc_layer.dart";
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
        onPositionChanged: (MapCamera camera, bool hasGesture) {
          if (hasGesture) {
            ref
                .read(isFollowingCurrentLocationControllerProvider.notifier)
                .mapMoved(); // stop following location on user interaction
          }
        },
        onTap:
            ref.watch(context.mapController<T>().notifier).onMapBackgroundTap,
      ),
      mapController: ref.watch(context.mapController<T>()),
          urlTemplate: OpenStreetMapConfig.tileUrl,
          userAgentPackageName: OpenStreetMapConfig.userAgent,
          userAgentPackageName:
              Platform.isIOS ? "com.solvro.ToPwr" : "com.solvro.topwr",
          tileProvider: CancellableNetworkTileProvider(),
        ),
        MarkersConsumerLayer<T>(),
        const MyLocationLayer(),
        Positioned(
          right: 0,
          top: MediaQuery.paddingOf(context).top,
          child: const MyLocationButton(),
        ),
        const OpenMapAtrribution(),
      ],
    );
  }
}

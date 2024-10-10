import "package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_cache/flutter_map_cache.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/map_view_config.dart";
import "../../../theme/app_theme.dart";
import "../../my_location_button/presentation/is_following_controller.dart";
import "../../my_location_button/presentation/my_loc_layer.dart";
import "../controllers/controllers_set.dart";
import "map_atrribution.dart";
import "map_config.dart";
import "markers_layer.dart";
import "toolbar.dart";

class MapWidget<T extends GoogleNavigable> extends ConsumerWidget {
  const MapWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: MapWidgetConfig.initialCenter,
        initialZoom: MapWidgetConfig.initialZoom,
        backgroundColor: context.colorTheme.whiteSoap,
        interactionOptions: MapWidgetConfig.interactionOptions,
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
      children: [
        TileLayer(
          urlTemplate: OpenStreetMapConfig.tileUrl,
          userAgentPackageName: OpenStreetMapConfig.userAgent,
          tileProvider: CachedTileProvider(
            maxStale: const Duration(days: MapCacheConfig.cacheDuration),
            store: HiveCacheStore(
              null,
              hiveBoxName: MapCacheConfig.cacheBoxName,
            ),
          ),
        ),
        MarkersConsumerLayer<T>(),
        const MyLocationLayer(),
        const Toolbar(),
        const OpenMapAtrribution(),
      ],
    );
  }
}

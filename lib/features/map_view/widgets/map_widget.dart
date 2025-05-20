import "package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_cache/flutter_map_cache.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../config/map_view_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../my_location_button/presentation/is_following_controller.dart";
import "../../my_location_button/presentation/my_loc_layer.dart";
import "../controllers/controllers_set.dart";
import "../data/cache.dart";
import "load_animated_controller.dart";
import "map_atrribution.dart";
import "map_config.dart";
import "markers_layer.dart";
import "toolbar.dart";

class MapWidget<T extends GoogleNavigable> extends HookConsumerWidget {
  const MapWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoadAnimationMapController<T>(
      myMapController: ref.watch(context.mapController<T>()),
      builder: (context, controller) {
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
            onTap: ref.watch(context.mapController<T>()).onMapBackgroundTap,
          ),
          mapController: controller.mapController,
          children: [
            Semantics(label: context.localize.map_view_description, child: const MapTileLayer()),
            ExcludeSemantics(child: MarkersConsumerLayer<T>()),
            const ExcludeSemantics(child: MyLocationLayer()),
            const Toolbar(),
            const ExcludeSemantics(child: OpenMapAtrribution()),
          ],
        );
      },
    );
  }
}

class MapTileLayer extends ConsumerWidget {
  const MapTileLayer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheStore = ref.watch(mapCacheStoreProvider);
    return switch (cacheStore) {
      AsyncData(:final DbCacheStore value) => TileLayer(
        urlTemplate: OpenStreetMapConfig.tileUrl,
        userAgentPackageName: OpenStreetMapConfig.userAgent,
        tileProvider: CachedTileProvider(maxStale: const Duration(days: MapCacheConfig.cacheDuration), store: value),
      ),
      _ =>
        const SizedBox.shrink(), // no need for fancy loading, cause it should be instant if prefetch is done in the splash screen
    };
  }
}

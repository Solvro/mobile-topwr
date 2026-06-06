import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_cache/flutter_map_cache.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:http_cache_drift_store/http_cache_drift_store.dart";

import "../../../config/map_view_config.dart";
import "../../../theme/app_theme.dart";
import "../../branches/business/selected_branch_on_map.dart";
import "../../multilayer_map/data/model/multilayer_item.dart";
import "../../my_loc_button/presentation/is_following_controller.dart";
import "../../my_loc_button/presentation/my_loc_layer.dart";
import "../controllers/controllers_set.dart";
import "../data/cache.dart";
import "../hooks/use_multilayer_branch_recenter.dart";
import "load_animated_controller.dart";
import "map_atrribution.dart";
import "map_config.dart";
import "markers_layer.dart";
import "toolbar.dart";

class MapWidget<T extends GoogleNavigable> extends HookConsumerWidget {
  final String semanticsLabel;
  const MapWidget(this.semanticsLabel, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapControllerProvider = context.mapController<T>();

    if (T == MultilayerItem) {
      // ignore: solvro_config/hooks_avoid_nesting this never change during runtime, it's a static condition
      useMultilayerBranchRecenter(
        ref: ref,
        selectedBranch: ref.watch(selectedBranchOnMapProvider),
        sourceState: ref.watch(context.mapSourceRepository<MultilayerItem>()),
        activeMarkerProvider: context.activeMarkerController<MultilayerItem>(),
        mapControllerProvider: context.mapController<MultilayerItem>(),
      );
    }

    return LoadAnimationMapController<T>(
      myMapController: ref.watch(mapControllerProvider),
      builder: (context, controller) {
        return FlutterMap(
          options: MapOptions(
            initialCenter: MapWidgetConfig.initialCenter,
            initialZoom: MapWidgetConfig.initialZoom,
            backgroundColor: context.colorScheme.surface,
            interactionOptions: MapWidgetConfig.interactionOptions,
            onPositionChanged: (MapCamera camera, bool hasGesture) {
              if (hasGesture) {
                ref
                    .read(isFollowingCurrentLocationControllerProvider.notifier)
                    .mapMoved(); // stop following location on user interaction
              }
            },
            onTap: (tapPosition, point) {
              unawaited(HapticFeedback.selectionClick());
              ref.watch(mapControllerProvider).onMapBackgroundTap(tapPosition, point);
            },
          ),
          mapController: controller.mapController,
          children: [
            Semantics(label: semanticsLabel, child: const MapTileLayer()),
            ExcludeSemantics(child: MarkersConsumerLayer<T>()),
            const ExcludeSemantics(child: MyLocationLayer()),
            Toolbar<T>(),
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
    if (kIsWeb) {
      return const _OpenStreetMapTileLayer();
    }

    final cacheStore = ref.watch(mapCacheStoreProvider);
    return switch (cacheStore) {
      AsyncData(:final DriftCacheStore value) => _OpenStreetMapTileLayer(
        tileProvider: CachedTileProvider(
          maxStale: const Duration(days: MapCacheConfig.cacheDuration),
          store: value,
        ),
      ),
      _ => const _OpenStreetMapTileLayer(),
    };
  }
}

class _OpenStreetMapTileLayer extends StatelessWidget {
  const _OpenStreetMapTileLayer({this.tileProvider});

  final TileProvider? tileProvider;

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: OpenStreetMapConfig.tileUrl,
      userAgentPackageName: OpenStreetMapConfig.userAgent,
      tileProvider: tileProvider,
    );
  }
}

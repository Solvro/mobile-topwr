import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/map_view_config.dart";
import "../../../gen/assets.gen.dart";
import "../../../utils/context_extensions.dart";
import "../../analytics/data/umami.dart";
import "../../analytics/data/umami_events.dart";
import "../../map_view/map_view.dart";
import "../controllers.dart";
import "../data/model/multilayer_item.dart";
import "multilater_tile.dart";

@RoutePage()
class MultilayerMapView extends ConsumerWidget {
  const MultilayerMapView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.buildings_title);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MapView<MultilayerItem>(
      mapViewTexts: (emptyList: context.localize.building_not_found, title: context.localize.buildings_title),
      initialActiveItemId: initialActiveItemId,
      animateListTiles: true,
      mapSheetSize: MapViewBottomSheetConfig.buildingsMapSheetSize,
      mapControllers: multilayerMapControllers,
      mapTileBuilder: MultilayerItemTile.new,
      markerBuilder: (item, ref, {required isActive}) => Marker(
        // TODO(simon-the-shark): different builders for different items
        alignment: Alignment.topCenter,
        point: item.location,
        child: GestureDetector(
          onTap: () {
            unawaited(ref.trackEvent(UmamiEvents.selectBuilding, value: item.toString()));
            unawaited(ref.read(multilayerMapControllerProvider).onMarkerTap(item));
          },
          child: Image.asset(
            isActive ? Assets.png.mapMarkers.activeMapMarker.path : Assets.png.mapMarkers.mapMarker.path,
          ),
        ),
      ),
      semanticsLabel: context.localize.map_view_description,
    );
  }
}

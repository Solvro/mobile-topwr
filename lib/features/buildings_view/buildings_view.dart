import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/map_view_config.dart";
import "../../gen/assets.gen.dart";
import "../../utils/context_extensions.dart";
import "../map_view/map_view.dart";
import "building_tile.dart";
import "controllers.dart";
import "model/building_model.dart";

@RoutePage()
class BuildingsView extends ConsumerWidget {
  const BuildingsView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MapView<BuildingModel>(
      mapViewTexts: (emptyList: context.localize.building_not_found, title: context.localize.buildings_title),
      initialActiveItemId: initialActiveItemId,
      animateListTiles: true,
      mapSheetSize: MapViewBottomSheetConfig.buildingsMapSheetSize,
      mapControllers: mapControllersBuildings,
      mapTileBuilder: BuildingTile.new,
      markerBuilder:
          (item, ref, {required isActive}) => Marker(
            alignment: Alignment.topCenter,
            point: item.location,
            child: GestureDetector(
              onTap: () {
                unawaited(ref.read(buildingsMapControllerProvider).onMarkerTap(item));
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

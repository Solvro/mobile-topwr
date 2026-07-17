import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/config/map_view_config.dart";
import "package:topwr/features/map_view/controllers/bottom_sheet_controller.dart";
import "package:topwr/features/map_view/widgets/map_config.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:topwr/features/multilayer_map/presentation/controllers.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/multilater_tile.dart";

Widget widgetbookMapConfigWrapper(Widget child) {
  return ProviderScope(
    overrides: [
      bottomSheetControllerProvider,
      bottomSheetPixelsProvider,
      multilayerMapControllers.map,
      multilayerMapControllers.activeMarker,
    ],
    child: MapConfig<MultilayerItem>(
      controllers: multilayerMapControllers,
      markerBuilder: (item, ref, {required isActive}) => Marker(
        point: item.location,
        child: Icon(Icons.location_on, color: isActive ? Colors.red : Colors.blue, size: 32),
      ),
      mapTileBuilder: MultilayerItemTile.new,
      mapViewTexts: const (emptyList: "No map items", title: "Map"),
      mapSheetSize: MapViewBottomSheetConfig.buildingsMapSheetSize,
      initialActiveItemId: null,
      initialQuery: null,
      child: child,
    ),
  );
}

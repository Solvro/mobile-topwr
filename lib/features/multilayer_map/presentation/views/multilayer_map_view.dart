import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/map_view_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../map_view/map_view.dart";
import "../../data/model/multilayer_item.dart";
import "../../data/model/multilayer_section_type.dart";
import "../controllers.dart";
import "../widgets/multilater_tile.dart";
import "../widgets/multilayer_marker.dart";

@RoutePage()
class MultilayerMapView extends ConsumerWidget {
  const MultilayerMapView({
    super.key,
    @PathParam("initialActiveItemId") this.initialActiveItemId,
    this.initialSectionType,
  });
  final String? initialActiveItemId;

  /// The section type to scroll to initially.
  final MultilayerSectionType? initialSectionType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialQuery = context.routeData.parent?.queryParams.optString("qMap");
    return MapView<MultilayerItem>(
      mapViewTexts: (emptyList: context.localize.building_not_found, title: context.localize.multilayer_map_title),
      initialActiveItemId: initialActiveItemId,
      initialQuery: initialQuery,
      initialSectionType: initialSectionType,
      animateListTiles: true,
      mapSheetSize: MapViewBottomSheetConfig.buildingsMapSheetSize,
      mapControllers: multilayerMapControllers,
      mapTileBuilder: MultilayerItemTile.new,
      markerBuilder: (item, ref, {required isActive}) => Marker(
        alignment: Alignment.topCenter,
        point: item.location,
        child: MultilayerMarker(item: item, isActive: isActive),
      ),
      semanticsLabel: context.localize.map_view_description,
    );
  }
}

import "package:auto_route/auto_route.dart";
import "package:flutter/widgets.dart";

import "../data/model/multilayer_item.dart";
import "multilayer_map_view.dart";

@RoutePage()
class BuildingsView extends StatelessWidget {
  const BuildingsView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;
  @override
  Widget build(BuildContext context) {
    return MultilayerMapView(initialActiveItemId: "${BuildingItem.idPrefix}$initialActiveItemId");
  }
}

@RoutePage()
class LibrariesView extends StatelessWidget {
  const LibrariesView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;
  @override
  Widget build(BuildContext context) {
    return MultilayerMapView(initialActiveItemId: "${LibraryItem.idPrefix}$initialActiveItemId");
  }
}

@RoutePage()
class AedsView extends StatelessWidget {
  const AedsView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;
  @override
  Widget build(BuildContext context) {
    return MultilayerMapView(initialActiveItemId: "${AedItem.idPrefix}$initialActiveItemId");
  }
}

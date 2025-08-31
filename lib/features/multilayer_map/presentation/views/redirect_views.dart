import "package:auto_route/auto_route.dart";
import "package:flutter/widgets.dart";

import "../../../../utils/context_extensions.dart";
import "../../data/model/multilayer_item.dart";
import "multilayer_map_view.dart";

@RoutePage()
class BuildingsView extends StatelessWidget {
  const BuildingsView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.buildings_title);
  }

  @override
  Widget build(BuildContext context) {
    return MultilayerMapView(initialActiveItemId: "${BuildingItem.idPrefix}$initialActiveItemId");
  }
}

@RoutePage()
class LibrariesView extends StatelessWidget {
  const LibrariesView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.library_title);
  }

  @override
  Widget build(BuildContext context) {
    return MultilayerMapView(initialActiveItemId: "${LibraryItem.idPrefix}$initialActiveItemId");
  }
}

@RoutePage()
class AedsView extends StatelessWidget {
  const AedsView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.aed_title);
  }

  @override
  Widget build(BuildContext context) {
    return MultilayerMapView(initialActiveItemId: "${AedItem.idPrefix}$initialActiveItemId");
  }
}

@RoutePage()
class ShowersView extends StatelessWidget {
  const ShowersView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.showers_title);
  }

  @override
  Widget build(BuildContext context) {
    return MultilayerMapView(initialActiveItemId: "${BicycleShowerItem.idPrefix}$initialActiveItemId");
  }
}

@RoutePage()
class PinkBoxesView extends StatelessWidget {
  const PinkBoxesView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.pink_boxes_title);
  }

  @override
  Widget build(BuildContext context) {
    return MultilayerMapView(initialActiveItemId: "${PinkBoxItem.idPrefix}$initialActiveItemId");
  }
}

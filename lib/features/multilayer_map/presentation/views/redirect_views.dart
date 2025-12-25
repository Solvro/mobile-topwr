import "package:auto_route/auto_route.dart";
import "package:flutter/widgets.dart";

import "../../../../utils/context_extensions.dart";
import "../../data/model/multilayer_section_type.dart";
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
    final hasSpecificId = initialActiveItemId != null && initialActiveItemId != "null";
    return MultilayerMapView(
      initialActiveItemId: "${MultilayerSectionType.building.idPrefix}$initialActiveItemId",
      initialSectionType: hasSpecificId ? null : MultilayerSectionType.building,
    );
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
    final hasSpecificId = initialActiveItemId != null && initialActiveItemId != "null";
    return MultilayerMapView(
      initialActiveItemId: "${MultilayerSectionType.library.idPrefix}$initialActiveItemId",
      initialSectionType: hasSpecificId ? null : MultilayerSectionType.library,
    );
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
    final hasSpecificId = initialActiveItemId != null && initialActiveItemId != "null";
    return MultilayerMapView(
      initialActiveItemId: "${MultilayerSectionType.aed.idPrefix}$initialActiveItemId",
      initialSectionType: hasSpecificId ? null : MultilayerSectionType.aed,
    );
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
    final hasSpecificId = initialActiveItemId != null && initialActiveItemId != "null";
    return MultilayerMapView(
      initialActiveItemId: "${MultilayerSectionType.bicycleShower.idPrefix}$initialActiveItemId",
      initialSectionType: hasSpecificId ? null : MultilayerSectionType.bicycleShower,
    );
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
    final hasSpecificId = initialActiveItemId != null && initialActiveItemId != "null";
    return MultilayerMapView(
      initialActiveItemId: "${MultilayerSectionType.pinkBox.idPrefix}$initialActiveItemId",
      initialSectionType: hasSpecificId ? null : MultilayerSectionType.pinkBox,
    );
  }
}

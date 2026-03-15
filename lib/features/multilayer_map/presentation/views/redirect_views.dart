import "package:auto_route/auto_route.dart";
import "package:flutter/widgets.dart";

import "../../data/model/multilayer_section_type.dart";
import "multilayer_map_view.dart";

@RoutePage()
class BuildingsView extends StatelessWidget {
  const BuildingsView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;

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
class PolinkasView extends StatelessWidget {
  const PolinkasView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;

  @override
  Widget build(BuildContext context) {
    final hasSpecificId = initialActiveItemId != null && initialActiveItemId != "null";
    return MultilayerMapView(
      initialActiveItemId: "${MultilayerSectionType.polinka.idPrefix}$initialActiveItemId",
      initialSectionType: hasSpecificId ? null : MultilayerSectionType.polinka,
    );
  }
}

@RoutePage()
class LibrariesView extends StatelessWidget {
  const LibrariesView({super.key, @PathParam("initialActiveItemId") this.initialActiveItemId});
  final String? initialActiveItemId;

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

  @override
  Widget build(BuildContext context) {
    final hasSpecificId = initialActiveItemId != null && initialActiveItemId != "null";
    return MultilayerMapView(
      initialActiveItemId: "${MultilayerSectionType.pinkBox.idPrefix}$initialActiveItemId",
      initialSectionType: hasSpecificId ? null : MultilayerSectionType.pinkBox,
    );
  }
}

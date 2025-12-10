import "dart:async";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../data/model/building.dart";
import "../../data/model/multilayer_item.dart";
import "../controllers.dart";

class BuildingNavLink extends ConsumerWidget {
  const BuildingNavLink({super.key, required this.building, required this.isActive});
  final Building building;
  final bool isActive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: context.textScaler.scale(2),
      right: WideTileCardConfig.imageSize + context.textScaler.scale(2),
      child: IconButton(
        tooltip: "${context.localize.building_nav_link_tooltip} ${building.name}",
        iconSize: context.textScaler.clamp(maxScaleFactor: 2).scale(22),
        visualDensity: VisualDensity.compact,
        color: isActive ? context.colorScheme.surface : context.colorScheme.secondary,
        icon: Icon(Icons.home_sharp, color: isActive ? context.colorScheme.surface : context.colorScheme.secondary),
        onPressed: () {
          unawaited(ref.read(multilayerMapControllerProvider).onMarkerTap(BuildingItem(building: building)));
        },
      ),
    );
  }
}

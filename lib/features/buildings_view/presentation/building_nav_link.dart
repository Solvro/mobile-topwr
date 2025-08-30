import "dart:async";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../data/model/building.dart";

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
        tooltip: context.localize.building_nav_link_tooltip + " ${building.name}",
        iconSize: context.textScaler.clamp(maxScaleFactor: 2).scale(22),
        visualDensity: VisualDensity.compact,
        color: isActive ? context.colorTheme.whiteSoap : context.colorTheme.greyPigeon,
        icon: Icon(
          Icons.account_balance_outlined,
          color: isActive ? context.colorTheme.whiteSoap : context.colorTheme.greyPigeon,
        ),
        onPressed: () {
          unawaited(ref.navigateBuildingDetailAction(building));
        },
      ),
    );
  }
}

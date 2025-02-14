import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/wide_tile_card.dart";
import "../navigator/utils/navigation_commands.dart";
import "controllers.dart";
import "model/building_model.dart";
import "utils/utils.dart";

class BuildingTile extends ConsumerWidget {
  const BuildingTile(
    this.building, {
    required this.isActive,
    super.key,
  });

  final BuildingModel building;
  final bool isActive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        PhotoTrailingWideTileCard(
          activeGradient: context.colorTheme.toPwrGradient,
          directusPhotoUrl: building.cover?.filename_disk,
          title:
              "${building.disableBuildingPrefix ? "" : "${context.localize.building_prefix} "}${building.name}",
          subtitle: context.changeNull(building.addressFormatted),
          isActive: isActive,
          onTap: () {
            unawaited(
              ref.read(buildingsMapControllerProvider).onMarkerTap(building),
            );
          },
        ),
        if (building.externalDigitalGuideMode != null &&
            building.externalDigitalGuideIdOrURL != null)
          Positioned(
            top: 2,
            right: WideTileCardConfig.imageSize,
            child: IconButton(
              iconSize: 18,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                Icons.info,
                color: isActive
                    ? context.colorTheme.whiteSoap
                    : context.colorTheme.greyPigeon,
              ),
              onPressed: () {
                unawaited(ref.navigateBuildingDetailAction(building));
              },
            ),
          ),
      ],
    );
  }
}

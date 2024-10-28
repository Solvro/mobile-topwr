import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/wide_tile_card.dart";
import "controllers.dart";
import "model/building_model.dart";
import "utils.dart";

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
    return PhotoTrailingWideTileCard(
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
    );
  }
}

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/ui_config.dart";
import "../../config/url_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/wide_tile_card.dart";
import "../navigator/utils/navigation_commands.dart";
import "controllers.dart";
import "model/building_model.dart";
import "utils/utils.dart";

class BuildingTile extends ConsumerWidget {
  const BuildingTile(this.building, {required this.isActive, super.key});

  final BuildingModel building;
  final bool isActive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Stack(
          children: [
            PhotoTrailingWideTileCard(
              activeGradient: context.colorTheme.toPwrGradient,
              directusPhotoUrl: building.coverUrl,
              title: "${context.localize.building_prefix} ${building.name}",
              subtitle: building.address,
              isActive: isActive,
              onTap: () {
                unawaited(ref.read(buildingsMapControllerProvider).onMarkerTap(building));
              },
            ),
            if (building.externalDigitalGuideIdOrURL != null)
              Positioned(
                top: 2,
                right: WideTileCardConfig.imageSize + 2,
                child: IconButton(
                  iconSize: 22,
                  visualDensity: VisualDensity.compact,
                  color: switch (building.externalDigitalGuideMode) {
                    "digital_guide_building" || "other_digital_guide_place" => context.colorTheme.orangePomegranade,
                    _ => null,
                  },
                  icon: Icon(
                    switch (building.externalDigitalGuideMode) {
                      "web_url" =>
                        building.externalDigitalGuideIdOrURL!.startsWith(UrlConfig.topwrUrl)
                            ? Icons.info
                            : Icons.language,
                      "digital_guide_building" || "other_digital_guide_place" => Icons.accessibility_new_rounded,
                      _ => Icons.info,
                    },
                    color:
                        isActive
                            ? context.colorTheme.whiteSoap
                            : switch (building.externalDigitalGuideMode) {
                              "digital_guide_building" ||
                              "other_digital_guide_place" => context.colorTheme.orangePomegranade,
                              _ => context.colorTheme.greyPigeon,
                            },
                  ),
                  onPressed: () {
                    unawaited(ref.navigateBuildingDetailAction(building));
                  },
                ),
              ),
          ],
        ),
        if (isActive &&
            (building.externalDigitalGuideMode == "digital_guide_building" ||
                building.externalDigitalGuideMode == "other_digital_guide_place"))
          TextButton.icon(
            icon: Icon(Icons.accessibility_new_rounded, color: context.colorTheme.orangePomegranade, size: 16),
            onPressed: () {
              unawaited(ref.navigateBuildingDetailAction(building));
            },
            style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
            label: Text(context.localize.navigate_to_digital_guide, style: context.textTheme.boldBodyOrange),
          ),
      ],
    );
  }
}

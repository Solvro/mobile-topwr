import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../config/url_config.dart";
import "../../../../gen/assets.gen.dart";
import "../../../../hooks/use_semantics_service_on_changed_value.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../../../navigator/utils/navigation_commands.dart";
import "../../data/model/building.dart";
import "../../data/model/multilayer_item.dart";
import "../controllers.dart";

class BuildingTile extends HookConsumerWidget {
  const BuildingTile(this.building, {required this.isActive, super.key});

  final Building building;
  final bool isActive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasDigitalGuide =
        building.externalDigitalGuideIdOrUrl != null &&
        (building.externalDigitalGuideMode == ExternalDigitalGuideMode.otherDigitalGuidePlace ||
            building.externalDigitalGuideMode == ExternalDigitalGuideMode.digitalGuideBuilding);

    final l10n = context.localize;
    useSemanticsServiceOnChangedValue(
      isActive,
      messageBuilder: (active) => active
          ? "${l10n.building_tile_selected} ${l10n.building_tile_building} ${building.name.replaceFirst("-", " ")}"
          : "${l10n.building_tile_unselected} ${l10n.building_tile_building} ${building.name.replaceFirst("-", " ")}",
    );

    return Column(
      children: [
        Stack(
          children: [
            Semantics(
              label:
                  "${isActive ? "${context.localize.building_tile_selected} " : ""}${context.localize.building_tile_building} ${building.name.replaceFirst("-", " ")}. ${context.localize.building_tile_address}: ${building.address}. ${hasDigitalGuide ? context.localize.building_tile_digital_guide_available : ""}",
              button: true,
              child: ExcludeSemantics(
                child: PhotoTrailingWideTileCard(
                  context,
                  activeGradient: context.colorTheme.toPwrGradient,
                  directusPhotoUrl: building.cover?.url,
                  title: "${context.localize.building_prefix} ${building.name}",
                  subtitle: building.address,
                  isActive: isActive,
                  onTap: () {
                    unawaited(ref.trackEvent(UmamiEvents.selectBuilding, value: building.name));
                    unawaited(ref.read(multilayerMapControllerProvider).onMarkerTap(BuildingItem(building: building)));
                  },
                  customPlaceholder: ColoredBox(
                    color: context.colorTheme.greyLight,
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.svg.mapPlaceholders.buildingIcon,
                        height: WideTileCardConfig.imageSize / 2,
                      ),
                    ),
                  ),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ),
            if (building.externalDigitalGuideIdOrUrl != null && building.externalDigitalGuideMode != null)
              Positioned(
                top: context.textScaler.scale(2),
                right: WideTileCardConfig.imageSize + context.textScaler.scale(2),
                child: IconButton(
                  tooltip: switch (building.externalDigitalGuideMode!) {
                    ExternalDigitalGuideMode.digitalGuideBuilding ||
                    ExternalDigitalGuideMode.otherDigitalGuidePlace => context.localize.navigate_to_digital_guide,
                    ExternalDigitalGuideMode.webUrl =>
                      building.externalDigitalGuideIdOrUrl!.startsWith(UrlConfig.topwrUrl)
                          ? context.localize.internal_link
                          : context.localize.external_link(building.externalDigitalGuideIdOrUrl!),
                  },
                  iconSize: context.textScaler.clamp(maxScaleFactor: 2).scale(22),
                  visualDensity: VisualDensity.compact,
                  color: switch (building.externalDigitalGuideMode) {
                    ExternalDigitalGuideMode.digitalGuideBuilding ||
                    ExternalDigitalGuideMode.otherDigitalGuidePlace => context.colorTheme.orangePomegranade,
                    _ => null,
                  },
                  icon: Icon(
                    switch (building.externalDigitalGuideMode!) {
                      ExternalDigitalGuideMode.webUrl =>
                        building.externalDigitalGuideIdOrUrl!.startsWith(UrlConfig.topwrUrl)
                            ? Icons.info
                            : Icons.language,
                      ExternalDigitalGuideMode.digitalGuideBuilding ||
                      ExternalDigitalGuideMode.otherDigitalGuidePlace => Icons.accessibility_new_rounded,
                    },
                    color: isActive
                        ? context.colorTheme.whiteSoap
                        : switch (building.externalDigitalGuideMode) {
                            ExternalDigitalGuideMode.digitalGuideBuilding ||
                            ExternalDigitalGuideMode.otherDigitalGuidePlace => context.colorTheme.orangePomegranade,
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
            (building.externalDigitalGuideMode == ExternalDigitalGuideMode.digitalGuideBuilding ||
                building.externalDigitalGuideMode == ExternalDigitalGuideMode.otherDigitalGuidePlace))
          TextButton.icon(
            icon: Icon(
              Icons.accessibility_new_rounded,
              color: context.colorTheme.orangePomegranade,
              size: context.textScaler.scale(16),
            ),
            onPressed: () {
              unawaited(ref.navigateBuildingDetailAction(building));
            },
            style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
            label: Text(
              context.localize.navigate_to_digital_guide,
              style: context.textTheme.boldBodyOrange,
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../config/url_config.dart";
import "../../../../gen/assets.gen.dart";
import "../../../../hooks/use_semantics_service_on_changed_value.dart";
import "../../../../theme/app_theme.dart";
import "../../../../theme/colors.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../../../analytics/data/clarity.dart";
import "../../../analytics/data/clarity_events.dart";
import "../../../navigator/utils/navigation_commands.dart";
import "../../data/model/building.dart";
import "../../data/model/multilayer_item.dart";
import "../../data/model/polinka_station.dart";
import "../controllers.dart";

class PolinkaTile extends HookConsumerWidget {
  const PolinkaTile(this.station, {required this.isActive, super.key});

  final PolinkaStation station;
  final bool isActive;

  String get _address =>
      "${station.addressLine1}\n${station.addressLine2 ?? ""}".replaceFirst(",", "\n").replaceAll("\n ", "\n");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasDigitalGuide =
        station.externalDigitalGuideIdOrUrl != null &&
        (station.externalDigitalGuideMode == ExternalDigitalGuideMode.otherDigitalGuidePlace ||
            station.externalDigitalGuideMode == ExternalDigitalGuideMode.digitalGuideBuilding);

    final l10n = context.localize;
    useSemanticsServiceOnChangedValue(
      isActive,
      messageBuilder: (active) => active
          ? "${l10n.building_tile_selected} ${station.name.replaceFirst("-", " ")}"
          : "${l10n.building_tile_unselected} ${station.name.replaceFirst("-", " ")}",
    );

    return Column(
      children: [
        Stack(
          children: [
            Semantics(
              label:
                  "${isActive ? "${context.localize.building_tile_selected} " : ""} ${station.name}. ${context.localize.building_tile_address}: $_address. ${hasDigitalGuide ? context.localize.building_tile_digital_guide_available : ""}",
              button: true,
              child: ExcludeSemantics(
                child: PhotoTrailingWideTileCard(
                  context,
                  activeGradient: ColorsConsts.toPwrGradient,
                  directusPhotoUrl: station.photo,
                  title: station.name,
                  subtitle: _address,
                  isActive: isActive,
                  onTap: () {
                    unawaited(ref.trackEvent(ClarityEvents.selectBuilding, value: station.name));
                    unawaited(ref.read(multilayerMapControllerProvider).onMarkerTap(PolinkaItem(station: station)));
                  },
                  customPlaceholder: ColoredBox(
                    color: context.colorScheme.surfaceTint,
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
            if (station.externalDigitalGuideIdOrUrl != null && station.externalDigitalGuideMode != null)
              Positioned(
                top: context.textScaler.scale(2),
                right: WideTileCardConfig.imageSize + context.textScaler.scale(2),
                child: IconButton(
                  tooltip: switch (station.externalDigitalGuideMode!) {
                    ExternalDigitalGuideMode.digitalGuideBuilding ||
                    ExternalDigitalGuideMode.otherDigitalGuidePlace => context.localize.navigate_to_digital_guide,
                    ExternalDigitalGuideMode.webUrl =>
                      station.externalDigitalGuideIdOrUrl!.startsWith(UrlConfig.topwrUrl)
                          ? context.localize.internal_link
                          : context.localize.external_link(station.externalDigitalGuideIdOrUrl!),
                  },
                  iconSize: context.textScaler.clamp(maxScaleFactor: 2).scale(22),
                  visualDensity: VisualDensity.compact,
                  color: switch (station.externalDigitalGuideMode) {
                    ExternalDigitalGuideMode.digitalGuideBuilding ||
                    ExternalDigitalGuideMode.otherDigitalGuidePlace => context.colorScheme.primary,
                    _ => null,
                  },
                  icon: Icon(
                    switch (station.externalDigitalGuideMode!) {
                      ExternalDigitalGuideMode.webUrl =>
                        station.externalDigitalGuideIdOrUrl!.startsWith(UrlConfig.topwrUrl)
                            ? Icons.info
                            : Icons.language,
                      ExternalDigitalGuideMode.digitalGuideBuilding ||
                      ExternalDigitalGuideMode.otherDigitalGuidePlace => Icons.accessibility_new_rounded,
                    },
                    color: isActive
                        ? context.colorScheme.surface
                        : switch (station.externalDigitalGuideMode) {
                            ExternalDigitalGuideMode.digitalGuideBuilding ||
                            ExternalDigitalGuideMode.otherDigitalGuidePlace => context.colorScheme.primary,
                            _ => context.colorScheme.tertiary,
                          },
                  ),
                  onPressed: () {
                    unawaited(ref.navigatePolinkaDetailAction(station));
                  },
                ),
              ),
          ],
        ),
        if (isActive &&
            (station.externalDigitalGuideMode == ExternalDigitalGuideMode.digitalGuideBuilding ||
                station.externalDigitalGuideMode == ExternalDigitalGuideMode.otherDigitalGuidePlace))
          TextButton.icon(
            icon: Icon(
              Icons.accessibility_new_rounded,
              color: context.colorScheme.primary,
              size: context.textScaler.scale(16),
            ),
            onPressed: () {
              unawaited(ref.navigatePolinkaDetailAction(station));
            },
            style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
            label: Text(
              context.localize.navigate_to_digital_guide,
              style: context.textTheme.bodyMedium!.copyWith(color: ColorsConsts.orangePomegranade),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}

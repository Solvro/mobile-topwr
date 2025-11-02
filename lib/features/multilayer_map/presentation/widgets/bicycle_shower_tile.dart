import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../gen/assets.gen.dart";
import "../../../../hooks/use_semantics_service_on_changed_value.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../../data/model/bicycle_shower.dart";
import "../../data/model/multilayer_item.dart";
import "../controllers.dart";
import "building_nav_link.dart";

class BicycleShowerTile extends HookConsumerWidget {
  const BicycleShowerTile(this.shower, {required this.isActive, super.key});

  final BicycleShower shower;
  final bool isActive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = shower.title(context.localize);
    final l10n = context.localize;
    useSemanticsServiceOnChangedValue(
      isActive,
      messageBuilder: (active) =>
          active ? "${l10n.building_tile_selected} $title" : "${l10n.building_tile_unselected} $title",
    );

    return Column(
      children: [
        Stack(
          children: [
            Semantics(
              label: "${isActive ? "${context.localize.building_tile_selected} " : ""} $title",
              button: true,
              child: ExcludeSemantics(
                child: PhotoTrailingWideTileCard(
                  context,
                  activeGradient: context.colorTheme.toPwrGradient,
                  directusPhotoUrl: shower.photo,
                  title: title,
                  subtitle: "${context.localize.room} ${shower.room}\n${shower.instructions}",
                  isActive: isActive,
                  onTap: () {
                    unawaited(ref.trackEvent(UmamiEvents.selectLibrary, value: title));
                    unawaited(ref.read(multilayerMapControllerProvider).onMarkerTap(BicycleShowerItem(shower: shower)));
                  },
                  customPlaceholder: ColoredBox(
                    color: context.colorTheme.greyLight,
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.svg.mapPlaceholders.showerIcon,
                        height: WideTileCardConfig.imageSize / 2,
                      ),
                    ),
                  ),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ),
            if (shower.building != null) BuildingNavLink(building: shower.building!, isActive: isActive),
          ],
        ),
      ],
    );
  }
}

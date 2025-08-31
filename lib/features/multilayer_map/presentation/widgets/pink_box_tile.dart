import "dart:async";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../hooks/use_semantics_service_on_changed_value.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../../data/model/multilayer_item.dart";
import "../../data/model/pink_box.dart";
import "../controllers.dart";
import "building_nav_link.dart";

class PinkBoxTile extends HookConsumerWidget {
  const PinkBoxTile(this.pinkBox, {required this.isActive, super.key});

  final PinkBox pinkBox;
  final bool isActive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = pinkBox.title(context.localize);
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
                  directusPhotoUrl: pinkBox.photo?.url,
                  title: title,
                  subtitle:
                      "${context.localize.building_tile_building} ${pinkBox.building?.name}\n${pinkBox.roomOrNearby}",
                  isActive: isActive,
                  onTap: () {
                    unawaited(ref.trackEvent(UmamiEvents.selectLibrary, value: title));
                    unawaited(ref.read(multilayerMapControllerProvider).onMarkerTap(PinkBoxItem(pinkBox: pinkBox)));
                  },
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ),
            if (pinkBox.building != null) BuildingNavLink(building: pinkBox.building!, isActive: isActive),
          ],
        ),
      ],
    );
  }
}

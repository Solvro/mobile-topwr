import "dart:async";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../hooks/use_semantics_service_on_changed_value.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../../data/model/aed.dart";
import "../../data/model/multilayer_item.dart";
import "../controllers.dart";
import "building_nav_link.dart";

class AedTile extends HookConsumerWidget {
  const AedTile(this.aed, {required this.isActive, super.key});

  final Aed aed;
  final bool isActive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = aed.title;
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
                  directusPhotoUrl: aed.photo?.url,
                  title: title,
                  subtitle: "${aed.addressLine1 ?? ''}\n${aed.addressLine2 ?? ''}".trim(),
                  isActive: isActive,
                  onTap: () {
                    unawaited(ref.trackEvent(UmamiEvents.selectAed, value: title));
                    unawaited(ref.read(multilayerMapControllerProvider).onMarkerTap(AedItem(aed: aed)));
                  },
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ),
            if (aed.building != null) BuildingNavLink(building: aed.building!, isActive: isActive),
          ],
        ),
      ],
    );
  }
}

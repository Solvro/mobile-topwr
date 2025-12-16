import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../gen/assets.gen.dart";
import "../../../../hooks/use_semantics_service_on_changed_value.dart";
import "../../../../theme/app_theme.dart";
import "../../../../theme/colors.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../../../analytics/data/clarity.dart";
import "../../../analytics/data/clarity_events.dart";
import "../../data/model/library.dart";
import "../../data/model/multilayer_item.dart";
import "../controllers.dart";
import "building_nav_link.dart";

class LibraryTile extends HookConsumerWidget {
  const LibraryTile(this.library, {required this.isActive, super.key});

  final Library library;
  final bool isActive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.localize;
    useSemanticsServiceOnChangedValue(
      isActive,
      messageBuilder: (active) => active
          ? "${l10n.building_tile_selected} ${library.title}"
          : "${l10n.building_tile_unselected} ${library.title}",
    );

    return Column(
      children: [
        Stack(
          children: [
            Semantics(
              label: "${isActive ? "${context.localize.building_tile_selected} " : ""} ${library.title}",
              button: true,
              child: ExcludeSemantics(
                child: PhotoTrailingWideTileCard(
                  context,
                  activeGradient: ColorsConsts.toPwrGradient,
                  directusPhotoUrl: library.photo,
                  title: library.title,
                  subtitle:
                      "${context.localize.room} ${library.room}\n${context.localize.building_tile_building} ${library.building?.name}",
                  isActive: isActive,
                  onTap: () {
                    unawaited(ref.trackEvent(ClarityEvents.selectLibrary, value: library.title));
                    unawaited(ref.read(multilayerMapControllerProvider).onMarkerTap(LibraryItem(library: library)));
                  },
                  customPlaceholder: ColoredBox(
                    color: context.colorScheme.surfaceTint,
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.svg.mapPlaceholders.libraryIcon,
                        height: WideTileCardConfig.imageSize / 2,
                      ),
                    ),
                  ),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ),
            if (library.building != null) BuildingNavLink(building: library.building!, isActive: isActive),
          ],
        ),
      ],
    );
  }
}

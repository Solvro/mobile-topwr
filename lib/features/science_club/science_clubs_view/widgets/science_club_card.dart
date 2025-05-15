import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/optimized_directus_image.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../model/science_clubs.dart";

class ScienceClubCard extends StatelessWidget {
  final ScienceClub sciClub;
  final VoidCallback? onTap;

  const ScienceClubCard(this.sciClub, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return WideTileCard(
      title: sciClub.name,
      subtitle: sciClub.department?.name,
      onTap: onTap,
      secondSubtitle: sciClub.tags?.map((tag) => "#${tag.tag}").toList().join(", "),
      showBadge: sciClub.source == ScienceClubsViewConfig.source,
      showStrategicBadge: sciClub.isStrategic,
      activeShadows: null,
      trailing: Padding(
        padding: const EdgeInsets.only(
          right: ScienceClubCardConfig.trailingPadding,
          top: ScienceClubCardConfig.trailingPadding,
          bottom: ScienceClubCardConfig.trailingPadding,
        ),
        child: SizedBox(
          width: WideTileCardConfig.imageSize,
          height: context.textScaler.scale(WideTileCardConfig.imageSize),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: WideTileCardConfig.radius,
                bottomRight: WideTileCardConfig.radius,
              ),
            ),
            child: OptimizedDirectusImage(
              sciClub.logo?.url,
              boxFit: BoxFit.scaleDown,
              loadingType: LoadingType.noLoading,
            ),
          ),
        ),
      ),
    );
  }
}

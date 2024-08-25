import "package:flutter/material.dart";

import "../../../api_base/directus_assets_url.dart";
import "../../../config/ui_config.dart";
import "../../../widgets/my_cached_image.dart";
import "../../../widgets/wide_tile_card.dart";
import "../repository/science_clubs_repository.dart";

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
      secondSubtitle: sciClub.tags
          ?.map((tag) => "#${tag?.Tags_id?.name}")
          .toList()
          .join(", "),
      activeShadows: null,
      trailing: Padding(
        padding: const EdgeInsets.only(
          right: ScienceClubCardConfig.trailingPadding,
          top: ScienceClubCardConfig.trailingPadding,
          bottom: ScienceClubCardConfig.trailingPadding,
        ),
        child: SizedBox.square(
          dimension: WideTileCardConfig.imageSize,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: WideTileCardConfig.radius,
                bottomRight: WideTileCardConfig.radius,
              ),
            ),
            child: MyCachedImage(
              sciClub.logo?.filename_disk.directusUrl,
              boxFit: BoxFit.contain,
              noShimmeringLoading: true,
            ),
          ),
        ),
      ),
    );
  }
}

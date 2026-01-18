import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/rest_api_image.dart";
import "../model/science_clubs.dart";
import "science_club_text.dart";

class ScienceClubCard extends StatelessWidget {
  final ScienceClub sciClub;
  final VoidCallback? onTap;

  const ScienceClubCard(this.sciClub, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    final subtitle = [
      ...?sciClub.tags?.map((tag) => "#${tag.tag}"),
      if (sciClub.department?.code != null) "#${sciClub.department?.code}",
    ].join(", ");

    return ClipRRect(
      borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceTint,
              borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
            ),
            child: SizedBox(
              height: context.textScaler.clamp(maxScaleFactor: 2).scale(WideTileCardConfig.imageSize),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: WideTileCardConfig.basePadding,
                        top: WideTileCardConfig.basePadding,
                        right: WideTileCardConfig.basePadding * 1.04,
                      ),
                      child: ScienceClubText(
                        title: sciClub.name,
                        titleStyle: Theme.of(context).textTheme.titleLarge,
                        subtitle: subtitle,
                        subtitleStyle: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: context.colorScheme.secondary),
                        spacing: WideTileCardConfig.titlesSpacing,
                        maxTotalLines: context.textScaleFactor > 1.5 ? 5 : 4,
                        showVerifiedBadge: sciClub.source == ScienceClubSource.manualEntry,
                        showStrategicBadge: sciClub.isStrategic,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Padding(
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
                        child: RestApiImage(sciClub.logo, boxFit: BoxFit.scaleDown, loadingType: LoadingType.noLoading),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

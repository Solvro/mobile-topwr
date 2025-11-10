import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/rest_api_image.dart";
import "../model/science_clubs.dart";
import "strategic_badge.dart";
import "verified_badge.dart";

class ScienceClubCard extends StatelessWidget {
  final ScienceClub sciClub;
  final VoidCallback? onTap;

  const ScienceClubCard(this.sciClub, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    final title = sciClub.name;
    final subtitle = sciClub.department?.name;
    final secondSubtitle = sciClub.tags?.map((tag) => "#${tag.tag}").toList().join(", ");
    final showVerifiedBadge = sciClub.source == ScienceClubSource.manualEntry;
    final showStrategicBadge = sciClub.isStrategic;

    final placeholderDimensions = [
      if (showVerifiedBadge) const PlaceholderDimensions(size: Size(12, 12), alignment: PlaceholderAlignment.middle),
      if (showStrategicBadge) const PlaceholderDimensions(size: Size(12, 12), alignment: PlaceholderAlignment.middle),
    ];

    TextSpan titleSpan({double? fontSize}) => TextSpan(
      text: title,
      style: context.textTheme.title,
      children: [if (showVerifiedBadge) const VerifiedBadge(), if (showStrategicBadge) const StrategicBadge()],
    );
    return ClipRRect(
      borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: context.colorTheme.greyLight,
              borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
            ),
            child: SizedBox(
              height: 440,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: WideTileCardConfig.basePadding,
                        top: WideTileCardConfig.basePadding,
                        right: WideTileCardConfig.basePadding * 1.04,
                        bottom: WideTileCardConfig.basePadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AutoSizeText.rich(
                            titleSpan(),
                            placeholderDimensions: placeholderDimensions,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (subtitle != null) const SizedBox(height: 2),
                          if (subtitle != null)
                            AutoSizeText.rich(
                              TextSpan(text: subtitle, style: context.textTheme.body),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (secondSubtitle != null) const SizedBox(height: 2),
                          if (secondSubtitle != null)
                            AutoSizeText.rich(
                              TextSpan(text: secondSubtitle, style: context.textTheme.bodyBlue),
                              maxLines: 2,
                              maxFontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
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

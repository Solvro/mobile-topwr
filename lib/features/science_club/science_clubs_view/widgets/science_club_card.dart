import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/calculate_lines.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/rest_api_image.dart";
import "../model/science_clubs.dart";
import "../utils/scale_extension.dart";
import "strategic_badge.dart";
import "verified_badge.dart";

class ScienceClubCard extends StatelessWidget {
  final ScienceClub sciClub;
  final VoidCallback? onTap;

  const ScienceClubCard(this.sciClub, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    final title = sciClub.name;
    final tags = sciClub.tags?.map((tag) => "#${tag.tag}").toList().join(", ");
    final showVerifiedBadge = sciClub.source == ScienceClubSource.manualEntry;
    final showStrategicBadge = sciClub.isStrategic;

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _TextContent(
                    title: title,
                    tags: tags,
                    showVerifiedBadge: showVerifiedBadge,
                    showStrategicBadge: showStrategicBadge,
                  ),
                ),
                const SizedBox(width: ScienceClubCardConfig.contentImageSpacing),
                Padding(
                  padding: const EdgeInsets.only(
                    right: ScienceClubCardConfig.trailingPadding,
                    top: ScienceClubCardConfig.trailingPadding,
                    bottom: ScienceClubCardConfig.trailingPadding,
                  ),
                  child: SizedBox(
                    width: ScienceClubCardConfig.imageWidth,
                    height: context.textScaler.scale(ScienceClubCardConfig.imageHeight),
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
    );
  }
}

class _TextContent extends StatelessWidget {
  final String title;
  final String? tags;
  final bool showVerifiedBadge;
  final bool showStrategicBadge;

  const _TextContent({
    required this.title,
    this.tags,
    required this.showVerifiedBadge,
    required this.showStrategicBadge,
  });

  @override
  Widget build(BuildContext context) {
    // if you look into the badges, they have sizes of 12 or 14 and a 4 left padding, hence the math
    final placeholderDimensions = [
      if (showVerifiedBadge) const PlaceholderDimensions(size: Size(16, 12), alignment: PlaceholderAlignment.middle),
      if (showStrategicBadge) const PlaceholderDimensions(size: Size(18, 12), alignment: PlaceholderAlignment.middle),
    ];

    TextSpan titleSpan({double? fontSize}) => TextSpan(
      text: title,
      style: fontSize != null ? context.textTheme.title.copyWith(fontSize: fontSize) : context.textTheme.title,
      children: [if (showVerifiedBadge) const VerifiedBadge(), if (showStrategicBadge) const StrategicBadge()],
    );

    return Padding(
      padding: const EdgeInsets.all(WideTileCardConfig.basePadding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final titleLines = TextSpan(text: title, style: context.textTheme.title).calculateLines(constraints.maxWidth);
          final badgesIn2ndLine =
              placeholderDimensions.isNotEmpty &&
              titleSpan(fontSize: 18).calculateLines(
                    constraints.maxWidth -
                        (showStrategicBadge ? 18 : 0) -
                        (showVerifiedBadge
                            ? 16
                            : 0), // if you look into the badges, they have sizes of 12 or 14 and a 4 left padding, hence the math
                    placeholderDimensions: placeholderDimensions,
                  ) >
                  titleLines;
          final int actualTitleLines = badgesIn2ndLine ? titleLines + 1 : titleLines;

          final scaleType = context.textScaleFactor.scaleType;
          final maxLines = calculateMaxLines(scaleType: scaleType, hasTags: tags != null, titleLines: actualTitleLines);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AutoSizeText.rich(
                titleSpan(),
                placeholderDimensions: placeholderDimensions,
                maxLines: maxLines.titleMaxLines,
                maxFontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
              if (tags != null && maxLines.tagsMaxLines > 0)
                const SizedBox(height: ScienceClubCardConfig.trailingPadding),
              if (tags != null && maxLines.tagsMaxLines > 0)
                AutoSizeText.rich(
                  TextSpan(text: tags, style: context.textTheme.bodyBlue),
                  maxLines: maxLines.tagsMaxLines,
                  maxFontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          );
        },
      ),
    );
  }
}

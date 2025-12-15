import "package:flutter/material.dart";

import "../api_base_rest/shared_models/image_data.dart";
import "../config/ui_config.dart";
import "../features/science_club/science_clubs_view/widgets/ensure_visible_tags.dart";
import "../theme/app_theme.dart";
import "../utils/context_extensions.dart";

import "rest_api_image.dart";

class PhotoTrailingWideTileCard extends WideTileCard {
  PhotoTrailingWideTileCard(
    BuildContext context, {
    ImageData? directusPhotoUrl,
    required super.title,
    super.subtitle,
    super.onTap,
    super.isActive,
    super.activeGradient,
    super.activeShadows,
    super.key,
    super.crossAxisAlignment,
    BoxFit boxFit = BoxFit.cover,
    Widget? customPlaceholder,
  }) : super(
         trailing: SizedBox(
           height: context.textScaler.scale(WideTileCardConfig.imageSize),
           width: WideTileCardConfig.imageSize,
           child: directusPhotoUrl != null ? RestApiImage(directusPhotoUrl, boxFit: boxFit) : customPlaceholder,
         ),
       );
}

class WideTileCard extends StatelessWidget {
  const WideTileCard({
    required this.title,
    this.subtitle = "",
    this.trailing,
    this.onTap,
    this.activeGradient,
    this.isActive = false,
    this.activeShadows = WideTileCardConfig.defaultActiveShadows,
    this.secondSubtitle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    super.key,
    this.showBadge = false,
    this.showStrategicBadge = false,
    this.fixedTrailingHeight = true,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final String? secondSubtitle;

  final bool isActive;

  final VoidCallback? onTap;

  final List<BoxShadow>? activeShadows;
  final LinearGradient? activeGradient;
  final CrossAxisAlignment crossAxisAlignment;
  final bool showBadge;
  final bool showStrategicBadge;
  final bool fixedTrailingHeight;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              gradient: isActive ? activeGradient : null,
              color: context.colorScheme.surfaceTint,
              borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
              boxShadow: isActive ? activeShadows : null,
            ),
            child: SizedBox(
              height: fixedTrailingHeight
                  ? context.textScaler.clamp(maxScaleFactor: 2).scale(WideTileCardConfig.imageSize)
                  : null,
              child: Row(
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  Expanded(
                    child: _TitlesColumn(
                      title,
                      subtitle,
                      secondSubtitle,
                      showBadge: showBadge,
                      showStrategicBadge: showStrategicBadge,
                      isActive: isActive,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ?trailing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitlesColumn extends StatelessWidget {
  const _TitlesColumn(
    this.title,
    this.subtitle,
    this.secondSubtitle, {
    required this.isActive,
    this.showBadge = false,
    this.showStrategicBadge = false,
  });

  final String title;
  final String? subtitle;
  final String? secondSubtitle;
  final bool isActive;
  final bool showBadge;
  final bool showStrategicBadge;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const basePadding = WideTileCardConfig.basePadding;
        final textColor = isActive ? context.colorScheme.surface : null;
        final textTheme = context.textTheme;

        return Padding(
          padding: const EdgeInsets.only(left: basePadding, top: basePadding, right: basePadding * 1.04),
          child: EnsureVisibleTags(
            title: title,
            titleStyle: textTheme.titleLarge?.copyWith(color: textColor),
            subtitle: subtitle,
            subtitleStyle: textTheme.bodyLarge?.copyWith(color: textColor),
            spacing: secondSubtitle == null ? WideTileCardConfig.titlesSpacing : 2,
            secondSubtitle: secondSubtitle,
            secondSubtitleStyle: textTheme.bodyLarge?.copyWith(
              color: isActive ? textColor : context.colorScheme.secondary,
            ),
            maxTotalLines: context.textScaleFactor > 1.5 ? 5 : 4,
            showVerifiedBadge: showBadge,
            showStrategicBadge: showStrategicBadge,
          ),
        );
      },
    );
  }
}

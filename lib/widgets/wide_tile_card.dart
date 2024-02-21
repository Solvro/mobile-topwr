import 'dart:math';

import 'package:flutter/material.dart';

import '../config.dart';
import '../theme/app_theme.dart';
import 'dual_text_max_lines.dart';
import 'my_cached_image.dart';

class PhotoTrailingWideTileCard extends WideTileCard {
  PhotoTrailingWideTileCard({
    String? photoUrl,
    required super.title,
    super.subtitle,
    super.onTap,
    super.isActive,
    super.activeGradient,
    super.activeShadows,
    super.key,
  }) : super(
          trailing: SizedBox.square(
            dimension: WideTileCardConfig.imageSize,
            child: MyCachedImage(photoUrl),
          ),
        );
}

class WideTileCard extends StatelessWidget {
  const WideTileCard({
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.activeGradient,
    this.isActive = false,
    this.activeShadows = WideTileCardConfig.defaultActiveShadows,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  final bool isActive;

  final VoidCallback? onTap;

  final List<BoxShadow>? activeShadows;
  final LinearGradient? activeGradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: isActive ? activeGradient : null,
          color: context.colorTheme.greyLight,
          borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          boxShadow: isActive ? activeShadows : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _TitlesColumn(
              title,
              subtitle,
              isActive,
            )),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _TitlesColumn extends StatelessWidget {
  const _TitlesColumn(
    this.title,
    this.subtitle,
    this.isActive,
  );

  final String title;
  final String? subtitle;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const basePadding = WideTileCardConfig.basePadding;
      final extraLeftPadding = max(
            constraints.maxWidth - WideTileCardConfig.minWidthForExtraPadding,
            0,
          ) *
          WideTileCardConfig.extraPaddingFactor;

      return Padding(
        padding: EdgeInsets.only(
          left: extraLeftPadding + basePadding,
          top: basePadding,
          right: basePadding,
        ),
        child: DualTextMaxLines(
          title: title,
          titleStyle:
              isActive ? context.textTheme.titleWhite : context.textTheme.title,
          subtitle: subtitle,
          subtitleStyle:
              isActive ? context.textTheme.bodyWhite : context.textTheme.body,
          spacing: WideTileCardConfig.titlesSpacing,
          maxTotalLines: 5,
        ),
      );
    });
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

import '../config.dart';
import '../theme/app_theme.dart';
import '../utils/context_extensions.dart';
import 'my_cached_image.dart';

class WideTileCard extends StatelessWidget {
  const WideTileCard({
    required this.title,
    this.subtitle,
    this.photoUrl,
    this.onTap,
    this.isActive = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? photoUrl;

  final bool isActive;

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: isActive ? context.colorTheme.toPwrGradient : null,
          color: context.colorTheme.greyLight,
          borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          boxShadow: isActive
              ? const [
                  BoxShadow(
                    color: Color.fromRGBO(250, 100, 101, 0.16),
                    blurRadius: 11.0,
                    spreadRadius: 6.0,
                  )
                ]
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Expanded(child: _TitlesColumn(title, subtitle, isActive)),
            SizedBox.square(
              dimension: WideTileCardConfig.imageSize,
              child: MyCachedImage(photoUrl),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitlesColumn extends StatelessWidget
    with WideTileCardCalcExtraPaddingLeft {
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
      return Padding(
        padding: EdgeInsets.only(
          left: calcExtraLeftPadding(constraints) + basePadding,
          top: basePadding,
          bottom: basePadding,
          right: basePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${context.localize?.building_prefix} $title",
              style: isActive
                  ? context.textTheme.titleWhite
                  : context.textTheme.title,
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: isActive
                    ? context.textTheme.bodyWhite
                    : context.textTheme.body,
              ),
          ],
        ),
      );
    });
  }
}

mixin WideTileCardCalcExtraPaddingLeft {
  double calcExtraLeftPadding(BoxConstraints constraints) {
    return max(
          constraints.maxWidth - WideTileCardConfig.minWidthForExtraPadding,
          0,
        ) *
        WideTileCardConfig.extraPaddingFactor;
  }
}

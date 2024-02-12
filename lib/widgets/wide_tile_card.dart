import 'dart:math';

import 'package:flutter/material.dart';

import '../config.dart';
import '../theme/app_theme.dart';
import '../utils/context_extensions.dart';
import 'my_cached_image.dart';

class WideTileCard extends StatelessWidget {
  const WideTileCard({
    this.isActive = false,
    required this.title,
    this.subtitle,
    super.key,
    this.photoUrl,
  });

  final String title;
  final String? subtitle;
  final String? photoUrl;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isActive ? context.colorTheme.toPwrGradient : null,
        color: context.colorTheme.greyLight,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
          _TitlesColumn(title, subtitle, isActive),
          SizedBox.square(
            dimension: 92,
            child: MyCachedImage(photoUrl),
          ),
        ],
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
    const basePadding = WideTileCardConfig.basePadding;
    final extraLeftPadding = max(
            MediaQuery.sizeOf(context).width -
                WideTileCardConfig.minWidthForExtraPadding,
            0) *
        WideTileCardConfig.extraPaddingFactor;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: extraLeftPadding + basePadding,
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
      ),
    );
  }
}

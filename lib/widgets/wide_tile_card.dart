import 'dart:math';

import 'package:flutter/material.dart';

import '../config.dart';
import '../theme/app_theme.dart';
import '../utils/context_extensions.dart';

class WideTileCard extends StatelessWidget {
  const WideTileCard({
    this.isActive = false,
    required this.title,
    this.subtitle,
    super.key,
  });

  final String title;
  final String? subtitle;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: context.colorTheme.greyLight,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(8),
      )),
      child: Row(
        children: [
          _TitlesColumn(title: title, subtitle: subtitle),
          const SizedBox.square(
            dimension: 92,
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}

class _TitlesColumn extends StatelessWidget {
  const _TitlesColumn({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    const basePadding = 16.0;
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
              style: context.textTheme.title,
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: context.textTheme.body,
              ),
          ],
        ),
      ),
    );
  }
}

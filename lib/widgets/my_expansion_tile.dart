import "package:flutter/material.dart";

import "../config/ui_config.dart";
import "../theme/app_theme.dart";
import "loading_widgets/shimmer_loading.dart";

class MyExpansionTile extends StatelessWidget {
  final bool initiallyExpanded;
  final String title;
  final List<Widget> children;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final void Function({bool expanded})? onExpansionChanged;

  const MyExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: key,
      title: Text(title, style: context.textTheme.titleLarge),
      backgroundColor: backgroundColor ?? context.colorScheme.surfaceTint,
      collapsedBackgroundColor: collapsedBackgroundColor ?? context.colorScheme.surfaceTint,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(GuideDetailViewConfig.borderRadius)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(GuideDetailViewConfig.borderRadius)),
      iconColor: context.colorScheme.primary,
      collapsedIconColor: context.colorScheme.primary,
      initiallyExpanded: initiallyExpanded,
      onExpansionChanged: (expanded) => onExpansionChanged?.call(expanded: expanded),
      children: children,
    );
  }
}

class MyExpansionTileLoading extends StatelessWidget {
  const MyExpansionTileLoading();

  @override
  Widget build(BuildContext context) {
    return ShimmerLoadingItem(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(GuideDetailViewConfig.borderRadius),
        ),
        width: double.infinity,
        height: 45,
      ),
    );
  }
}

import "package:flutter/material.dart";

import "../config/ui_config.dart";
import "../theme/app_theme.dart";
import "loading_widgets/shimmer_loading.dart";

class MyExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const MyExpansionTile({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title, style: context.textTheme.title),
      backgroundColor: context.colorTheme.greyLight,
      collapsedBackgroundColor: context.colorTheme.greyLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(GuideDetailViewConfig.borderRadius),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(GuideDetailViewConfig.borderRadius),
      ),
      iconColor: context.colorTheme.orangePomegranade,
      collapsedIconColor: context.colorTheme.orangePomegranade,
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
          borderRadius:
              BorderRadius.circular(GuideDetailViewConfig.borderRadius),
        ),
        width: double.infinity,
        height: 45,
      ),
    );
  }
}

import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/loading_widgets/shimmer_loading.dart";

class MyExpansionTile extends StatelessWidget {
  final String title;
  final String description;

  const MyExpansionTile({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: GuideDetailViewConfig.paddingMedium,
      ),
      child: ExpansionTile(
        title: Text(title, style: context.textTheme.title),
        backgroundColor: context.colorTheme.greyLight,
        collapsedBackgroundColor: context.colorTheme.greyLight,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(GuideDetailViewConfig.borderRadius),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(GuideDetailViewConfig.borderRadius),
        ),
        iconColor: context.colorTheme.orangePomegranade,
        collapsedIconColor: context.colorTheme.orangePomegranade,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: GuideDetailViewConfig.paddingSmall,
            ),
            child: ListTile(
              title: Text(
                description,
                style: context.textTheme.body.copyWith(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
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

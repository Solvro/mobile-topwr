import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../data/models/adapted_toilet.dart";

@RoutePage()
class AdaptedToiletDetailView extends ConsumerWidget {
  const AdaptedToiletDetailView({
    required this.adaptedToilet,
  });

  final AdaptedToilet adaptedToilet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: DetailViewAppBar(
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.heightMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localize.adapted_toilet_description,
              style: context.textTheme.title.copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: DigitalGuideConfig.heightMedium,
            ),
            Text(
              "• ${adaptedToilet.translations.plTranslation.location}",
              style: context.textTheme.body.copyWith(fontSize: 16),
            ),
            Text(
              "• ${adaptedToilet.translations.plTranslation.numberOfCabins}",
              style: context.textTheme.body.copyWith(fontSize: 16),
            ),
            if (!adaptedToilet.isAccessAccessibleForPwd)
              Text(
                "• ${adaptedToilet.translations.plTranslation.isAccessAccessibleForPwdComment}",
                style: context.textTheme.body.copyWith(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

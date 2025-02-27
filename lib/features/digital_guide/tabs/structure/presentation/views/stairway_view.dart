import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../navigator/utils/navigation_commands.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../../../presentation/widgets/digital_guide_photo_row.dart";
import "../../data/bussiness/stairway_accessibility_comments_manager.dart";
import "../../data/models/stairway.dart";

@RoutePage()
class StairwayView extends ConsumerWidget {
  const StairwayView({required this.stairway});

  final Stairway stairway;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StairwayTranslation stairwayInformation =
        stairway.translations.plTranslation;

    return Scaffold(
      appBar: DetailViewAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.heightBig,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: DigitalGuideConfig.heightBig,
          ),
          itemCount: 6 + stairway.stairsIds.length + stairway.doorsIds.length + (stairway.imagesIds.isNotEmpty ? 2 : 0),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Text(
                stairway.translations.plTranslation.name,
                style: context.textTheme.headline
                    .copyWith(fontSize: DigitalGuideConfig.headlineFont),
              );
            } else if (index == 1) {
              return const SizedBox(
                height: DigitalGuideConfig.heightSmall,
              );
            } else if (index == 2) {
              return BulletList(
                items: [
                  stairwayInformation.location,
                  stairwayInformation.comment,
                ].where((item) => item.trim().isNotEmpty).toIList(),
              );
            } else if (index == 3) {
              return const SizedBox(
                height: DigitalGuideConfig.heightSmall,
              );
            } else if (index == 4) {
              return AccessibilityProfileCard(
                accessibilityCommentsManager:
                    StairwayAccessibilityCommentsManager(
                  stairway: stairway,
                  l10n: context.localize,
                ),
                backgroundColor: context.colorTheme.whiteSoap,
              );
            } else if (index == 5) {
              return const SizedBox(height: DigitalGuideConfig.heightBig);
            } else if (index < 6 + stairway.stairsIds.length) {
              int stairsIndex = index - 6;
              return DigitalGuideNavLink(
                onTap: () async =>
                    ref.navigateDigitalGuideStairs(stairway.stairsIds[stairsIndex]),
                text: context.localize.stairs,
              );
            } else if (index < 6 + stairway.stairsIds.length + stairway.doorsIds.length) {
              int doorsIndex = index - 6 - stairway.stairsIds.length;
              return DigitalGuideNavLink(
                onTap: () async => ref.navigateDigitalGuideDoor(
                  stairway.doorsIds[doorsIndex],
                ),
                text: context.localize.door,
              );
            } else if (stairway.imagesIds.isNotEmpty && index == 6 + stairway.stairsIds.length + stairway.doorsIds.length) {
              return Text(
                context.localize.images,
                style: context.textTheme.title
                    .copyWith(fontSize: DigitalGuideConfig.headlineFont),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DigitalGuideConfig.heightBig,
                  vertical: DigitalGuideConfig.heightBig,
                ),
                child: DigitalGuidePhotoRow(
                  imagesIDs: stairway.imagesIds,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

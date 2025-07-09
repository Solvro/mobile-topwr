import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../navigator/utils/navigation_commands.dart";
import "../../../../presentation/widgets/accessibility_button.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../../../presentation/widgets/digital_guide_photo_row.dart";
import "../../business/stairway_accessibility_comments_manager.dart";
import "../../data/models/stairway.dart";

@RoutePage()
class StairwayView extends ConsumerWidget {
  const StairwayView({required this.stairway});

  final Stairway stairway;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StairwayTranslation stairwayInformation = stairway.translations.plTranslation;

    final widgets = [
      Text(
        stairway.translations.plTranslation.name,
        style: context.textTheme.headline.copyWith(fontSize: DigitalGuideConfig.headlineFont),
      ),
      const SizedBox(height: DigitalGuideConfig.heightSmall),
      BulletList(items: [stairwayInformation.location, stairwayInformation.comment].toIList()),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      AccessibilityProfileCard(
        accessibilityCommentsManager: StairwayAccessibilityCommentsManager(stairway: stairway, l10n: context.localize),
        backgroundColor: context.colorTheme.whiteSoap,
      ),
      if (stairway.imagesIds.isNotEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.paddingMedium),
          child: DigitalGuidePhotoRow(imagesIDs: stairway.imagesIds, semanticsLabel: context.localize.stairs),
        ),
      if (stairway.stairsIds.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: stairway.stairsIds.length,
        itemBuilder: (context, index) => DigitalGuideNavLink(
          onTap: () async => ref.navigateDigitalGuideStairs(stairway.stairsIds[index]),
          text: context.localize.stairs,
        ),
        separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightMedium),
      ),
      if (stairway.doorsIds.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: stairway.doorsIds.length,
        itemBuilder: (context, index) => DigitalGuideNavLink(
          onTap: () async => ref.navigateDigitalGuideDoor(stairway.doorsIds[index]),
          text: context.localize.door,
        ),
        separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightMedium),
      ),
    ];
    return Scaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.heightBig),
        child: ListView.builder(itemBuilder: (context, index) => widgets[index], itemCount: widgets.length),
      ),
    );
  }
}

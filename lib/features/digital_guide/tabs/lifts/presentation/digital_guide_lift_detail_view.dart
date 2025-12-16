import "package:auto_route/annotations.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_image.dart";
import "../business/lifts_accessibility_comments_manager.dart";
import "../data/models/digital_guide_lift.dart";

@RoutePage()
class DigitalGuideLiftDetailView extends ConsumerWidget {
  const DigitalGuideLiftDetailView(this.levelName, {required this.lift});

  final DigitalGuideLift lift;
  final String levelName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liftInformation = lift.translations.pl;
    final widgets = [
      Text(
        context.localize.localization,
        style: context.textTheme.headlineMedium?.copyWith(fontSize: DigitalGuideConfig.headlineFont),
      ),
      Padding(
        padding: const EdgeInsets.only(top: DigitalGuideConfig.heightMedium, bottom: DigitalGuideConfig.heightSmall),
        child: Text(levelName, style: context.textTheme.headlineMedium),
      ),
      Text(liftInformation.location, style: context.textTheme.bodyLarge),
      Padding(
        padding: const EdgeInsets.only(top: DigitalGuideConfig.heightSmall, bottom: DigitalGuideConfig.heightSmall),
        child: Text(context.localize.key_information, style: context.textTheme.headlineMedium),
      ),
      BulletList(
        items: [
          "${context.localize.floors_served_by_lift}: ${liftInformation.floorsList}",
          "${context.localize.dimensions}: ${liftInformation.liftDimensions}",
          "${context.localize.max_capacity}: ${liftInformation.maximumLiftCapacity}",
        ].toIList(),
      ),
      AccessibilityProfileCard(
        accessibilityCommentsManager: LiftsAccessibilityCommentsManager(l10n: context.localize, liftResponse: lift),
        backgroundColor: context.colorScheme.surface,
      ),
      if (lift.imagesIds != null && lift.imagesIds!.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
    ];
    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
        child: CustomScrollView(
          slivers: [
            SliverList(delegate: SliverChildBuilderDelegate((_, index) => widgets[index], childCount: widgets.length)),
            if (lift.imagesIds != null)
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(DigitalGuideConfig.heightMedium),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusSmall),
                      child: DigitalGuideImage(id: lift.imagesIds![index]),
                    ),
                  );
                }, childCount: lift.imagesIds!.length),
              ),
          ],
        ),
      ),
    );
  }
}

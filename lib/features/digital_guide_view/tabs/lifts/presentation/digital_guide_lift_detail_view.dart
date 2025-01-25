import "package:auto_route/annotations.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../utils/ilist_nonempty.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_photo_row.dart";
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
        style: context.textTheme.headline.copyWith(fontSize: 22),
      ),
      Padding(
        padding: const EdgeInsets.only(
          top: DigitalGuideConfig.heightMedium,
          bottom: DigitalGuideConfig.heightSmall,
        ),
        child: Text(
          levelName,
          style: context.textTheme.headline,
        ),
      ),
      Text(
        liftInformation.location,
        style: context.textTheme.body,
      ),
      Padding(
        padding: const EdgeInsets.only(
          top: DigitalGuideConfig.heightSmall,
          bottom: DigitalGuideConfig.heightSmall,
        ),
        child: Text(
          context.localize.key_information,
          style: context.textTheme.headline,
        ),
      ),
      BulletList(
        items: [
          "${context.localize.floors_served_by_lift}: ${liftInformation.floorsList}",
          "${context.localize.dimensions}: ${liftInformation.liftDimensions}",
          "${context.localize.max_capacity}: ${liftInformation.maximumLiftCapacity}",
        ].toIList(),
      ),
      if (lift.imagesIds != null && lift.imagesIds!.isNotEmpty)
        const SizedBox(
          height: DigitalGuideConfig.heightMedium,
        ),
      DigitalGuidePhotoRow(imagesIDs: lift.imagesIds.toIList()),
    ];
    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(
        actions: [AccessibilityButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widgets.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => widgets[index],
        ),
      ),
    );
  }
}

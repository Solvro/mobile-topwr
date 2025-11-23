import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../presentation/widgets/accessibility_button.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/digital_guide_photo_row.dart";
import "../../../lodge/business/lodge_accessibility_comments_manager.dart";
import "../../../lodge/data/models/digital_guide_lodge.dart";

@RoutePage()
class LodgeView extends ConsumerWidget {
  const LodgeView({required this.lodge, super.key});

  final DigitalGuideLodge lodge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lodgeInformation = lodge.translations.pl;

    return Scaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.all(DigitalGuideConfig.paddingBig),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              container: true,
              label: context.localize.lodge,
              excludeSemantics: true,
              child: Text(
                context.localize.lodge,
                style: context.textTheme.headline.copyWith(fontSize: DigitalGuideConfig.headlineFont),
              ),
            ),
            const SizedBox(height: DigitalGuideConfig.heightSmall),
            Semantics(container: true, child: Text(context.localize.localization, style: context.textTheme.title)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.heightSmall),
              child: Text(lodgeInformation.location),
            ),
            if (lodgeInformation.workingDaysAndHours.isNotEmpty)
              Semantics(container: true, child: Text(context.localize.working_hours, style: context.textTheme.title)),
            if (lodgeInformation.workingDaysAndHours.isNotEmpty)
              Semantics(
                container: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.heightSmall),
                  child: Text(lodgeInformation.workingDaysAndHours),
                ),
              ),
            if (lodgeInformation.comment.isNotEmpty)
              Semantics(
                container: true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: DigitalGuideConfig.paddingSmall),
                  child: Text(context.localize.additional_information, style: context.textTheme.title),
                ),
              ),
            Semantics(container: true, child: Text(lodgeInformation.comment)),
            if (lodgeInformation.comment.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
            DigitalGuidePhotoRow(imagesIDs: lodge.imagesIds?.toIList() ?? const IList.empty()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.paddingBig),
              child: AccessibilityProfileCard(
                accessibilityCommentsManager: LodgeAccessibilityCommentsManager(l10n: context.localize, lodge: lodge),
                backgroundColor: context.colorTheme.whiteSoap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

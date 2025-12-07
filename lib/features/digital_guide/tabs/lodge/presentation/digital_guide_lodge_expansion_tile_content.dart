import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../data/models/digital_guide_response.dart";
import "../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../presentation/widgets/digital_guide_photo_row.dart";
import "../business/lodge_accessibility_comments_manager.dart";
import "../data/models/digital_guide_lodge.dart";
import "../data/repository/lodges_repository.dart";

class DigitalGuideLodgeExpansionTileContent extends ConsumerWidget {
  const DigitalGuideLodgeExpansionTileContent(this.digitalGuideResponse);

  final DigitalGuideResponse digitalGuideResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lodgeResponse = ref.watch(lodgesRepositoryProvider(digitalGuideResponse));
    return lodgeResponse.when(
      data: (data) => _DigitalGuideLodgeExpansionTileContent(lodge: data.firstOrNull),
      error: (error, stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _DigitalGuideLodgeExpansionTileContent extends StatelessWidget {
  final DigitalGuideLodge? lodge;

  const _DigitalGuideLodgeExpansionTileContent({required this.lodge});

  @override
  Widget build(BuildContext context) {
    if (lodge == null) {
      return Center(child: Text(context.localize.no_lodge_in_the_building));
    }
    final lodgeInformation = lodge!.translations.pl;
    return Padding(
      padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            container: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.localize.localization, style: context.textTheme.title),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.heightSmall),
                  child: Text(lodgeInformation.location),
                ),
              ],
            ),
          ),
          if (lodgeInformation.workingDaysAndHours.isNotEmpty)
            Semantics(
              container: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(context.localize.working_hours, style: context.textTheme.title),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.heightSmall),
                    child: Text(lodgeInformation.workingDaysAndHours),
                  ),
                ],
              ),
            ),
          if (lodgeInformation.comment.isNotEmpty)
            Semantics(
              container: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: DigitalGuideConfig.paddingSmall),
                    child: Text(context.localize.additional_information, style: context.textTheme.title),
                  ),
                  Text(lodgeInformation.comment),
                ],
              ),
            ),
          if (lodgeInformation.comment.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
          DigitalGuidePhotoRow(imagesIDs: lodge!.imagesIds?.toIList() ?? const IList.empty()),
          Semantics(
            container: true,

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.paddingBig),
              child: AccessibilityProfileCard(
                accessibilityCommentsManager: LodgeAccessibilityCommentsManager(l10n: context.localize, lodge: lodge!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

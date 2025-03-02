import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../data/models/digital_guide_response.dart";
import "../../../presentation/widgets/accessibility_information_cards_list.dart";
import "../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_photo_row.dart";
import "../business/surroundings_accessibility_comments_manager.dart";
import "../data/models/surrounding_response.dart";
import "../data/repository/surrounding_repository.dart";

class SurroundingsExpansionTileContent extends ConsumerWidget {
  const SurroundingsExpansionTileContent({required this.digitalGuideData});

  final DigitalGuideResponse digitalGuideData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSurroundingData = ref.watch(surroundingRepositoryProvider(digitalGuideData));

    return asyncSurroundingData.when(
      data: (surroundingData) => _SurroundingExpansionTileContent(surroundingResponse: surroundingData),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _SurroundingExpansionTileContent extends ConsumerWidget {
  const _SurroundingExpansionTileContent({required this.surroundingResponse});

  final SurroundingResponse surroundingResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = [
      const SizedBox(height: DigitalGuideConfig.heightSmall),
      AccessibilityInformationCardsList(
        padding: const EdgeInsets.only(bottom: DigitalGuideConfig.paddingMedium),
        prefix: context.localize.surroundings,
        accessibilityLevelType: context.localize.accessibility_level_neuter,
        accLevels: (
          accessibilityLevelForBlind: surroundingResponse.accessibilityLevelForBlind,
          accessibilityLevelForVisuallyImpaired: surroundingResponse.accessibilityLevelForVisuallyImpaired,
          accessibilityLevelForMotorDisability: surroundingResponse.accessibilityLevelForMotorDisability,
          accessibilityLevelForCognitiveDifficulties: surroundingResponse.accessibilityLevelForCognitiveDifficulties,
          accessibilityLevelForHardOfHearing: surroundingResponse.accessibilityLevelForHardOfHearing,
          accessibilityLevelForHighSensorySensitivity: surroundingResponse.accessibilityLevelForHighSensorySensitivity,
        ),
      ),
      BulletList(
        items:
            [
              context.localize.parking_location(surroundingResponse.translations.plTranslation.areParkingSpacesComment),
              context.localize.closest_facilities(surroundingResponse.translations.plTranslation.closestBuildings),
            ].toIList(),
      ),
      AccessibilityProfileCard(
        accessibilityCommentsManager: SurroundingsAccessibilityCommentsManager(
          surroundingResponse: surroundingResponse,
          l10n: context.localize,
        ),
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      DigitalGuidePhotoRow(imagesIDs: surroundingResponse.images.lock),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.paddingMedium),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widgets.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => widgets[index],
      ),
    );
  }
}

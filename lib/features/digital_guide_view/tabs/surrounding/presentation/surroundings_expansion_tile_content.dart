import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../gen/assets.gen.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../../digital_guide_view/data/models/digital_guide_response_extended.dart";
import "../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../../presentation/widgets/digital_guide_photo_row.dart";
import "../data/models/surrounding_response_extended.dart";
import "../data/repository/surrounding_repository.dart";
import "../utils/surrounding_response_operations.dart";
import "widgets/accessibility_information_cards_list.dart";

class SurroundingsExpansionTileContent extends ConsumerWidget {
  const SurroundingsExpansionTileContent({
    required this.digitalGuideResponseExtended,
  });

  final DigitalGuideResponseExtended digitalGuideResponseExtended;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSurroundingData = ref.watch(
      getSurroundingDataExtendedProvider(
        digitalGuideResponseExtended.surroundingId,
      ),
    );

    return asyncSurroundingData.when(
      data: (surroundingData) => _SurroundingExpansionTileContent(
        surroundingResponse: surroundingData,
      ),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _SurroundingExpansionTileContent extends ConsumerWidget {
  const _SurroundingExpansionTileContent({
    required this.surroundingResponse,
  });

  final SurroundingResponseExtended surroundingResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = [
      AccessibilityInformationCardsList(
        surroundingResponse: surroundingResponse,
      ),
      const SizedBox(
        height: DigitalGuideConfig.heightMedium,
      ),
      BulletList(
        items: [
          context.localize.parking_location(
            surroundingResponse
                .translations.plTranslation.areParkingSpacesComment,
          ),
          context.localize.closest_facilities(
            surroundingResponse.translations.plTranslation.closestBuildings,
          ),
        ].toIList(),
      ),
      const SizedBox(
        height: DigitalGuideConfig.heightMedium,
      ),
      AccessibilityProfileCard(
        items: getSurroundingsCommentsList(surroundingResponse, context),
        icon: Assets.svg.digitalGuide.accessibilityAlerts.blindProfile,
      ),
      const SizedBox(
        height: DigitalGuideConfig.heightMedium,
      ),
      DigitalGuidePhotoRow(imageUrls: surroundingResponse.imagesUrl),
      const SizedBox(
        height: DigitalGuideConfig.heightMedium,
      ),
      DigitalGuideNavLink(
        onTap: () => {},
        text:
            context.localize.see_all_photos(surroundingResponse.images.length),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DigitalGuideConfig.paddingMedium,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widgets.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => widgets[index],
      ),
    );
  }
}

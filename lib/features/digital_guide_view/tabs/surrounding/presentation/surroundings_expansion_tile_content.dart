import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../gen/assets.gen.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../../digital_guide_view/data/models/digital_guide_response_extended.dart";
import "../../../../navigation_tab_view/widgets/navigation_tile.dart";
import "../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../data/models/surrounding_response.dart";
import "../data/repository/surrounding_repository.dart";
import "../utils/surrounding_response_operations.dart";
import "difficulties_information_cards_list.dart";


class SurroundingsExpansionTileContent extends ConsumerWidget {
  const SurroundingsExpansionTileContent({
    required this.digitalGuideResponseExtended,
  });

  final DigitalGuideResponseExtended digitalGuideResponseExtended;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSurroundingData = ref.watch(
      getSurroundingDataProvider(digitalGuideResponseExtended.surroundingId),
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

  final SurroundingResponse surroundingResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        DifficultiesInformationCardsList(
          surroundingResponse: surroundingResponse,
        ),
        BulletList(items: [context.localize.parking_location(
            surroundingResponse.translations.plTranslation.areParkingSpacesComment, 
        ),
        context.localize.closest_facilities(
          surroundingResponse.translations.plTranslation.closestBuildings,
          ),],),
        AccessibilityProfileCard(
          items: getSurroundingsCommentsList(surroundingResponse, context),
          icon: Assets.svg.digitalGuide.accessibilityAlerts.blindProfile,
        ),
        NavigationTile(title: "djhhdfdhfhdf"),

      ],
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../general_info/data/models/digital_guide_response_extended.dart";
import "../data/models/surrounding_response.dart";
import "../data/repository/surrounding_repository.dart";

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
        Text(
          context.localize.parking_location(
            surroundingResponse.translations.translationPl.parkingSpacesComment,
          ),
        ),
      ],
    );
  }
}

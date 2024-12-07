import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../general_info/data/models/digital_guide_response.dart";
import "../data/models/surrounding_response.dart";
import "../data/repository/surrounding_repository.dart";

class SurroundingsExpansionTileContent extends ConsumerWidget {
  const SurroundingsExpansionTileContent({
    required this.digitalGuideResponse,
  });

  final DigitalGuideResponse digitalGuideResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSurroundingData = ref
        .watch(getSurroundingDataProvider(digitalGuideResponse.surroundingId));

    return asyncSurroundingData.when(
      data: (surroundingData) => _SurroundingExpansionTileContent(
          surroundingResponse: surroundingData),
      // To-do nice error screen
      error: (error, stackTrace) => Text("API error occured: $error"),
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
        Text(context.localize.parking_location(surroundingResponse
            .translations.translationPl.parkingSpacesComment)),
      ],
    );
  }
}

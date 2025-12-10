import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../data/models/digital_guide_response.dart";
import "../data/models/digital_guide_entrace.dart";
import "../data/repository/entraces_repository.dart";
import "digital_guide_entrance_widget.dart";

class EntrancesExpansionTileContent extends ConsumerWidget {
  const EntrancesExpansionTileContent({required this.digitalGuideData});

  final DigitalGuideResponse digitalGuideData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entrances = ref.watch(entrancesRepositoryProvider(digitalGuideData));
    return entrances.when(
      data: _EntrancesExpansionTileContent.new,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
    );
  }
}

class _EntrancesExpansionTileContent extends ConsumerWidget {
  const _EntrancesExpansionTileContent(this.entrances);

  final IList<DigitalGuideEntrace> entrances;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: DigitalGuideConfig.heightMedium,
        horizontal: DigitalGuideConfig.heightMedium,
      ),
      child: Material(
        color: context.colorScheme.surfaceTint,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: entrances.map((entrance) {
            return DigitalGuideEntranceWidget(entrance: entrance);
          }).toList(),
        ),
      ),
    );
  }
}

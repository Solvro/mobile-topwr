import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../data/models/digital_guide_response.dart";
import "../domain/digital_guide_lifts_use_cases.dart";
import "digital_guide_lift_level.dart";

class DigitalGuideLiftExpansionTileContent extends ConsumerWidget {
  const DigitalGuideLiftExpansionTileContent({
    required this.digitalGuideResponse,
  });

  final DigitalGuideResponse digitalGuideResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsWithLifts =
        ref.watch(getLevelWithLiftsUseCaseProvider(digitalGuideResponse));
    return levelsWithLifts.when(
      data: (data) =>
          _DigitalGuideLiftExpansionTileContent(levelsWithLifts: data),
      error: (error, _) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _DigitalGuideLiftExpansionTileContent extends ConsumerWidget {
  const _DigitalGuideLiftExpansionTileContent({required this.levelsWithLifts});

  final IList<LevelWithLifts> levelsWithLifts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DigitalGuideConfig.paddingMedium,
        vertical: DigitalGuideConfig.paddingMedium,
      ),
      child: Material(
        color: context.colorTheme.greyLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: levelsWithLifts.map((level) {
            return DigitalGuideLiftLevel(
              level: level.level,
              lifts: level.lifts,
            );
          }).toList(),
        ),
      ),
    );
  }
}

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../data/models/digital_guide_response.dart";
import "../../../data/models/level_with_regions.dart";
import "../../../data/repository/levels_repository.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";

class StructureExpansionTileContent extends ConsumerWidget {
  const StructureExpansionTileContent({required this.digitalGuideData});

  final DigitalGuideResponse digitalGuideData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelDataAsync = ref.watch(levelsWithRegionsRepositoryProvider(digitalGuideData));

    return levelDataAsync.when(
      data: (data) => _StructureExpansionTileContent(digitalGuideResponse: digitalGuideData, levels: data),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
    );
  }
}

class _StructureExpansionTileContent extends ConsumerWidget {
  const _StructureExpansionTileContent({required this.digitalGuideResponse, required this.levels});

  final DigitalGuideResponse digitalGuideResponse;
  final IList<LevelWithRegions> levels;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        top: DigitalGuideConfig.heightMedium,
        left: DigitalGuideConfig.heightMedium,
        right: DigitalGuideConfig.heightMedium,
      ),
      child: Material(
        color: context.colorTheme.greyLight,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder:
              (context, index) => DigitalGuideNavLink(
                onTap: () async {
                  await ref.navigateDigitalGuideLevel(levels[index]);
                },
                text: levels[index].level.translations.plTranslation.name,
              ),
          separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightMedium),
          itemCount: levels.length,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
